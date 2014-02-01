class HabtmSubjectsTeachers < ActiveRecord::Migration
  def change
    create_table :subjects_teachers do |t|
      t.belongs_to :teacher
      t.belongs_to :subject
    end
  end
end
