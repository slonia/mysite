desc 'check timeline for mentions'
task check_tweets: :environment do
  TweetProcessor.prepare_tweets
end
