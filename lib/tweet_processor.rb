class TweetProcessor
  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key        = AppConfig.twitter_bot['consumer_key']
    config.consumer_secret     = AppConfig.twitter_bot['consumer_secret']
    config.access_token        = AppConfig.twitter_bot['access_token']
    config.access_token_secret = AppConfig.twitter_bot['access_token_secret']
  end

  class << self

    def prepare_tweets
      options = {count: 40}
      last_processed = TwitLog.last.try(:tweet_id)
      options.merge({since_id: last_processed.to_i}) if last_processed.present?

      tweets = CLIENT.mentions_timeline(options)
      tweets = strip_extra_info(tweets)
      tweets.each do |tweet|
        SemanticWorker.perform_async(tweet)
      end
    end

    def strip_extra_info(tweets)
      tweets.map do |tweet|
        {
          text: tweet.full_text.gsub(/@\w+\s*/,''),
          id: tweet.id
        }
      end
    end

    def reply_to(id, text = '')
      tweet = CLIENT.status(id.to_i)
      log = TweetLog.find_or_initialize_by_tweet_id(id.to_s)
      text = "@#{tweet.user.username}, сейчас #{Time.now.in_time_zone('Minsk').strftime('%H:%M') } так что ПИШИ КУРСАЧ!!!"
      log.update_attributes(reply: text)
      CLIENT.update(text)
    end
  end
end
