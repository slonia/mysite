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
  extend Enumerize

  belongs_to :cathedra
  has_and_belongs_to_many :subjects
  has_many :lessons

  validates :surname, :name, :patronymic, :degree, presence: true

  enumerize :degree, in: [:head, :professor, :docent, :senior,
                          :assistant, :lab_head, :engineer1, :engineer2,
                          :technician1, :technician2, :senior_researcher, :researcher, :software_engineer,
                          :laboratorian1, :laboratorian2]

  attr_reader :full_name

  def full_name
    [surname, name, patronymic].join(' ')
  end
end
