# == Schema Information
#
# Table name: lessons
#
#  id             :integer          not null, primary key
#  day            :integer
#  number         :integer
#  on_second_week :boolean
#  second_group   :boolean
#  subject_id     :integer
#  teacher_id     :integer
#  room_id        :integer
#  lesson_type    :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class Lesson < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  belongs_to :room

  validates :subject, :teacher, :room, presence: true
end
