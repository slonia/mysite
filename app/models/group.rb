# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  term       :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Group < ActiveRecord::Base
  has_many :lessons

  validates :name, :term, presence: true
end
