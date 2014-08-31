
class SemanticProcessor
  STEMMER = YandexMystem::Extended
  OBJECTS = [:lesson, :teacher, :room]

  NUMS = {
    'первый' => 1,
    'второй' => 2,
    'третий' => 3,
    'четвертый' => 4,
    'пятый' => 5,
    'шестой' => 6,
    'седьмой' => 7,
    'восьмой' => 8,
    'девятый' => 9,
    'десятый' => 10,
    'одиннадцатый' => 11,
    'двенадцатый' => 12,
    'тринадцатый' => 13,
    'четырнадцатый' => 14,
    'пятнадцатый' => 15,
    'шестнадцатый' => 16,
    'семнадцатый' => 17,
    'восемнадцатый' => 18,
    'девятнадцатый' => 19,
    'двадцатый' => 20
  }

  GOOD = %w(хорошо верно правильно достойно отлично безошибочно
            нормально неплохо годно качественно превосходно недурно
            хороший верный правильный достойный отличный безошибочный
            нормальный неплохой годный качественный превосходный недурный)

  BAD = %w(плохо отвратительно неверно ошибочно ошибка нехорошо неудовлетворительно паршиво
           плохой отвратительный неверный ошибочный нехороший неудовлетворительный паршивый)

  attr_accessor :text, :id, :user_id, :reply_to, :date, :log, :processed_text, :numbers

  def initialize(tweet)
    tweet.symbolize_keys!
    @text = tweet[:text]
    @id = tweet[:id]
    @user_id = tweet[:user_id].to_s
    @reply_to = tweet[:reply_to].to_s
    @log = TweetLog.find_or_initialize_by(tweet_id: id.to_s)
    process
  end

  private

    def process
      @processed_text = STEMMER.stem(text).map do |key,value|
        new_val = value.max_by {|v| v['frequency']}
        Hash[key, new_val]
      end.inject(:merge)
      @log.update_attributes(full_text: text, processed_text: processed_text)

      if @reply_to.blank?
        process_as_query
      else
        reply_log = TweetLog.find_by(tweet_id: @reply_to)
        process_as_reply(reply_log)
      end
    end

    def process_as_reply(reply_log)
      return if reply_log.nil?
      result = nil
      processed_text.each do |k,v|
        word = v.word
        if word.in?(GOOD)
          result = :good
          entity = Hash[:good, word.to_sym]
        elsif word.in?(BAD)
          result = :bad
          entity = Hash[:bad, word.to_sym]
        end

        if result.present?
          @log.update_attributes(entity: entity)
          reply_log.update_attributes(quality: result)
          break
        end
      end
    end

    def process_as_query
      ent = find_entities
      @log.update_attributes(entity: ent)
      user = User.find_by_twitter_id(@user_id)
      if user && user.group
        @date = DateParser.parse(text)
        if @date.nil? || ent.blank?
          @log.update_attributes(quality: :bad)
        end
        @date ||= Date.today
        reply_text = user.group.find_for_day(@date, ent.keys, @numbers)
      else
        reply_text = 'Для работы с системой зарегистрируйтесь на сайте http://studentime.info/users/auth/twitter'
      end
      TweetProcessor.reply_to(id, reply_text)
    end

    def find_entities
      answ = {}
      @numbers ||= []
      processed_text.each do |k, v|
        word = v.word
        res = {}
        @numbers << (NUMS[word] - 1) if v.part == 'ANUM'
        OBJECTS.each do |obj_name|
          obj = obj_name.to_s.camelize.constantize
          names = []
          obj::NAMES.each do |name|
            names << name if name == word
          end
          res.merge!({obj_name => names}) if names.present?
        end
        answ.merge!(res)
      end
      answ
    end
end
