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

  NAMES = %w(урок пара предмет занятие что)

  belongs_to :day
  belongs_to :subject
  belongs_to :teacher
  belongs_to :room

  validates :subject, presence: true

  enumerize :lesson_type, in: [:lection, :practice, :other, :seminar], default: :lection

  def teacher_and_name
    res = teacher_and_room
    blank ? nil : [name, res].compact.join(', ')
  end

  def teacher_and_room
    res = teacher.try(:short_name) || ''
    res += " (#{room.number})" if room
  end

  def name
    blank ? 'форточка' : subject.name.mb_chars.titleize.to_s
  end

end
