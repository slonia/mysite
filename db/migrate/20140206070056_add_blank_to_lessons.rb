class AddBlankToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :blank, :boolean, null: false, default: false
  end
end
