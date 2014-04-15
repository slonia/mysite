class AddIndexToTweetLogs < ActiveRecord::Migration
  def change
    add_index :tweet_logs, :tweet_id
  end
end
