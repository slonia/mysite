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
      last_processed = TweetLog.order(:tweet_id).last.try(:tweet_id)
      options.merge!({since_id: last_processed.to_i}) if last_processed.present?

      tweets = CLIENT.mentions_timeline(options)
      tweets.each do |tweet|
        puts tweet.class.to_s
        tw = {text: tweet.full_text.gsub(/@\w+\s*/,''),
                                        id: tweet.id,
                                        user_id: tweet.user.id}
        if Rails.env.production?
          SemanticWorker.perform_async(tw)
        else
          SemanticProcessor.new(tw)
        end
      end
    end

    def reply_to(id, text = '')
      tweet = CLIENT.status(id.to_i)
      log = TweetLog.find_or_initialize_by(tweet_id: id.to_s)
      text = check_length(text, tweet.user.username)
      log.update_attributes(reply: text.to_s)
      text.each {|part| CLIENT.update(part, in_reply_to_status_id: id); sleep(3) }
    end

    def check_length(text, username)
      name_length = username.length + 3
      name = "@#{username}, "
      if (text.length + name_length) > 140
        words = text.split(' ')
        newtext = name
        result = []
        words.each_with_index do |word, i|
          if (newtext + word).length < 140
            newtext += word + ' '
            result << newtext if i == words.length - 1
          else
            result << newtext
            newtext = name + word
          end
        end
        result
      else
        [name + text]
      end
    end
  end
end
