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

  belongs_to :group
  has_many :lessons
  accepts_nested_attributes_for :lessons

  validates :group, :number, presence: true
end
