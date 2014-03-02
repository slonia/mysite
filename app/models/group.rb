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
  has_many :days

  validates :name, :term, presence: true
  accepts_nested_attributes_for :days

  after_save :check_days

  scope :for_current_term, -> do
    today = Date.today
    term_start = Date.today.change(month: 2, day: 1)
    odd = [1, 3, 5, 7, 9]
    even = [2, 4, 6, 8, 10]
    today < term_start ? where(term: odd) : where(term: even)
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
