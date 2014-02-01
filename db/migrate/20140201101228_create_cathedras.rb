class CreateCathedras < ActiveRecord::Migration
  def change
    create_table :cathedras do |t|
      t.integer :number
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
