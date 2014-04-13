class SemanticProcessor
  STEMMER = YandexMystem::Extended

  class << self
    def answer(tweet)
      TweetProcessor.reply_to(tweet[:id])
    end
  end

end
