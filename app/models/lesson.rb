# == Schema Information
#
# Table name: lessons
#
#  id             :integer          not null, primary key
#  number         :integer
#  on_second_week :boolean          default(FALSE), not null
#  second_group   :boolean          default(FALSE), not null
#  subject_id     :integer
#  teacher_id     :integer
#  room_id        :integer
#  lesson_type    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  day_id         :integer          not null
#

class Lesson < ActiveRecord::Base
  default_scope { order(:number) }

  belongs_to :day
  belongs_to :subject
  belongs_to :teacher
  belongs_to :room

  validates :subject, :teacher, :room, :day, :number, presence: true
end
