class ChangeReplyToText < ActiveRecord::Migration
  def up
    change_column :tweet_logs, :reply, :text
  end

  def down
    change_column :tweet_logs, :reply, :string
  end
end
