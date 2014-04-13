class SemanticProcessor
  STEMMER = YandexMystem::Extended

  def initialize(tweet)
    TweetProcessor.reply_to(tweet[:id])
  end
end
