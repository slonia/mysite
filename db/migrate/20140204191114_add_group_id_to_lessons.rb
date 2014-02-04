class AddGroupIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :group_id, :integer, null: false
  end
end
