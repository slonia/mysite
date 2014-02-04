class SetDefaultValuesForBoolValuesInLessons < ActiveRecord::Migration
  def up
    change_column :lessons, :on_second_week, :boolean, null: false, default: false
    change_column :lessons, :second_group, :boolean, null: false, default: false
  end

  def down
    change_column :lessons, :on_second_week, :boolean
    change_column :lessons, :second_group, :boolean
  end
end

