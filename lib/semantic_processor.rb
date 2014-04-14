class SemanticProcessor
  STEMMER = YandexMystem::Extended

  attr_accessor :text, :id

  def initialize(tweet)
    tweet.symbolize_keys!
    @text = tweet[:text]
    @id = tweet[:id]
    log = TweetLog.find_or_initialize_by(tweet_id: id)
    processed_text = process
    log.update_attributes(full_text: text, processed_text: processed_text)
    TweetProcessor.reply_to(id)
  end

  def process
    STEMMER.stem(text).map do |key,value|
      new_val = value.max_by {|v| v['frequency']}
      Hash[key, new_val]
    end
  end
end
