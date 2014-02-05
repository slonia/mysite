class CreateDays < ActiveRecord::Migration
  def up
    create_table :days do |t|
      t.references :group, index: true
      t.integer :number, null: false

      t.timestamps
    end

    remove_column :lessons, :day
  end

  def down
    drop_table :days

    add_column :lessons, :day, :integer
  end
end
