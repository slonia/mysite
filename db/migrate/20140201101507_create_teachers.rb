class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :surname, null: false
      t.string :name, null: false
      t.string :patronymic, null: false
      t.string :degree
      t.references :cathedra, index: true

      t.timestamps
    end
  end
end
