class CreateTweetLogs < ActiveRecord::Migration
  def change
    create_table :tweet_logs do |t|
      t.string :tweet_id, null: false
      t.string :full_text
      t.hstore :processed_text
      t.string :reply

      t.timestamps
    end
  end
end
