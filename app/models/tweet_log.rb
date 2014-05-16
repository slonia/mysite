class TweetLog < ActiveRecord::Base
  validate :tweet_id, presence: true
end
