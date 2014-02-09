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
  default_scope { order(:number) }

  validates :name, presence: true
  validates :name, :number, uniqueness: true

  has_many :teachers

  def full_name
    prefix = number.present? ? "#{number}. " : ''
    prefix + name
  end
end
