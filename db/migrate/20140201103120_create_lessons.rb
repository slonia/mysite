class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :day
      t.integer :number
      t.boolean :on_second_week
      t.boolean :second_group
      t.references :subject, index: true
      t.references :teacher, index: true
      t.references :room, index: true
      t.string :lesson_type

      t.timestamps
    end
  end
end
