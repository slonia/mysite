# == Schema Information
#
# Table name: cathedras
#
#  id          :integer          not null, primary key
#  number      :integer
#  name        :string(255)      not null
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Cathedra < ActiveRecord::Base
  validates :name, presence: true

  has_many :teachers
end
