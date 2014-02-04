class AddSixDaysWeekToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :six_day_week, :boolean, null: false, default: false
  end
end
