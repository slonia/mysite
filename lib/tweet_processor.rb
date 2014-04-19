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
      last_processed = TweetLog.last.try(:tweet_id)
      options.merge!({since_id: last_processed.to_i}) if last_processed.present?

      tweets = CLIENT.mentions_timeline(options)
      processed = 0
      tweets.each do |tweet|
        puts tweet.class.to_s
        SemanticWorker.perform_async({text: tweet.full_text.gsub(/@\w+\s*/,''), id: tweet.tweet_id})
        processed += 1
      end
      processed.to_s
    end

    def reply_to(id, text = '')
      tweet = CLIENT.status(id.to_i)
      log = TweetLog.find_or_initialize_by(tweet_id: id.to_s)
      text = "@#{tweet.user.username}, сейчас #{Time.now.in_time_zone('Minsk').strftime('%H:%M') } так что ПИШИ КУРСАЧ!!!"
      log.update_attributes(reply: text)
      CLIENT.update(text)
    end
  end
end
