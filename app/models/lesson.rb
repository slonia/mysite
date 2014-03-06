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
#  blank          :boolean          default(FALSE), not null
#

class Lesson < ActiveRecord::Base
  extend Enumerize
  default_scope { order(:number) }

  belongs_to :day
  belongs_to :subject
  belongs_to :teacher
  belongs_to :room

  validates :subject, presence: true

  enumerize :lesson_type, in: [:lection, :practice, :other, :seminar], default: :lection

  def teacher_and_name
    res = teacher.try(:short_name) || ''
    res += " (#{room.number})" if room
    res
  end
end
