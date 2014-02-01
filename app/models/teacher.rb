# == Schema Information
#
# Table name: teachers
#
#  id          :integer          not null, primary key
#  surname     :string(255)      not null
#  name        :string(255)      not null
#  patronymic  :string(255)      not null
#  degree      :string(255)
#  cathedra_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Teacher < ActiveRecord::Base
  belongs_to :cathedra
  has_many :subjects
  has_many :lessons

  validates :surname, :name, :patronymic, :degree, presence: true
end
