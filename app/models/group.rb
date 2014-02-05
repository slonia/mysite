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

  private

    def check_days
      days_num = self.six_day_week ? 6 : 5
      days_count = self.days.count
      days_num -= days_count
      (days_count...days_num).each do |i|
        day = self.days.build
        day.number = i
        day.save
      end
    end
end
