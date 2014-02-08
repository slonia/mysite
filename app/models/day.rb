# == Schema Information
#
# Table name: days
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  number     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Day < ActiveRecord::Base
  default_scope { order(:number) }

  DAY_NAMES = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

  belongs_to :group
  has_many :lessons
  accepts_nested_attributes_for :lessons, allow_destroy: true

  validates :group, :number, presence: true

  before_validation :set_lesson_numbers

  private

    def set_lesson_numbers
      self.lessons.each_with_index do |lesson, n|
        lesson.number = n
      end
    end
end
