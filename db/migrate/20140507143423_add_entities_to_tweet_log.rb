class AddEntitiesToTweetLog < ActiveRecord::Migration
  def change
    add_column :tweet_logs, :entity, :hstore
  end
end
