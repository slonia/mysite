class AddDayIdToLessons < ActiveRecord::Migration
  def up
    add_column :lessons, :day_id, :integer, null: false
    remove_column :lessons, :group_id
  end

  def down
    remove_column :lessons, :day_id
    add_column :lessons, :group_id, :integer
  end
end
