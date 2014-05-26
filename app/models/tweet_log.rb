class TweetLog < ActiveRecord::Base
  extend Enumerize

  validate :tweet_id, presence: true

  enumerize :quality, in: [:good, :bad]
end
