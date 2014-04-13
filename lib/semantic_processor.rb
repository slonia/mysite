class SemanticProcessor
  STEMMER = YandexMystem::Extended

  def initialize(tweet)
    tweet.symbolize_keys!
    TweetProcessor.reply_to(tweet[:id])
  end
end
