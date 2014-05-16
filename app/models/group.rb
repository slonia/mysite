# == Schema Information
#
# Table name: groups
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  term         :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#  six_day_week :boolean          default(FALSE), not null
#

class Group < ActiveRecord::Base
  default_scope { order(:term).order(:name) }
  has_many :days

  validates :name, :term, presence: true
  accepts_nested_attributes_for :days

  after_save :check_days

  scope :for_current_term, -> do
    # today = Date.today
    # term_start = Date.today.change(month: 2, day: 1)
    # odd = [1, 3, 5, 7, 9]
    # even = [2, 4, 6, 8, 10]
    # today < term_start ? where(term: odd) : where(term: even)

  end

  def find_for_day(date, entities = [], at = [])
    dayn = date.wday
    if dayn == 0
      dayn = 6
     else
      dayn -= 1
    end
    day = days[dayn]
    lessons = at.blank? ? day.lessons : day.lessons.select { |l| l.number.in?(at) }
    subjects = lessons.map do |lesson|
      result = lesson.name
      result += " (#{lesson.room.number})" if entities.include?(:room) && lesson.room
      result += " - #{lesson.teacher.initials}" if entities.include?(:teacher) && lesson.teacher
      result
    end if day.present?
    subjects.try(:join, ', ') || ''
  end

  def name_with_term
    "#{term} семестр, #{name} группа"
  end

  private

    def check_days
      days_num = self.six_day_week ? 6 : 5
      days_count = self.days.count
      if days_count < days_num
        (days_count...days_num).each do |i|
          day = self.days.build
          day.number = i
          day.save
        end
      else
        self.days.last(days_count - days_num).map(&:destroy)
      end
    end
end
