class AddQualityToTweetLog < ActiveRecord::Migration
  def change
    add_column :tweet_logs, :quality, :string
  end
end
