class TweetLog < ActiveRecord::Base
  default_scope { order(:tweet_id) }

  validate :tweet_id, presence: true
end
