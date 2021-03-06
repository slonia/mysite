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

  belongs_to :group, touch: true
  has_many :lessons
  accepts_nested_attributes_for :lessons, allow_destroy: true

  validates :group, :number, presence: true

end
