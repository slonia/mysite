class SemanticProcessor
  STEMMER = YandexMystem::Extended

  attr_accessor :text, :id, :user_id, :date, :log

  def initialize(tweet)
    tweet.symbolize_keys!
    @text = tweet[:text]
    @id = tweet[:id]
    @user_id = tweet[:user_id].to_s
    @log = TweetLog.find_or_initialize_by(tweet_id: id.to_s)
    process
  end

  def process
    i = -1
    processed_text = STEMMER.stem(text).map do |key,value|
      new_val = value.max_by {|v| v['frequency']}
      i += 1
      Hash[i, Hash[key, new_val]]
    end.inject(:merge)

    @log.update_attributes(full_text: text, processed_text: processed_text)
    @date = DateParser.parse(text) || Date.today
    user = User.find_by_twitter_id(@user_id)
    reply_text = user.group.find_for_date(@date)
    TweetProcessor.reply_to(id, reply_text)
  end
end
