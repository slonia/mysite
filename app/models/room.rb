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
  validates :number, presence: true
end
