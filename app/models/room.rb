# == Schema Information
#
# Table name: rooms
#
#  id         :integer          not null, primary key
#  number     :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Room < ActiveRecord::Base
  default_scope { order(:number) }

  NAMES = %w(кабинет комната место где)

  validates :number, presence: true
end
