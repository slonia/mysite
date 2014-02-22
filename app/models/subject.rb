# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  terms      :integer          default([])
#  created_at :datetime
#  updated_at :datetime
#

class Subject < ActiveRecord::Base
  default_scope { order(:name) }
  has_many :lessons
  has_and_belongs_to_many :teachers

  validates :name, :terms, presence: true
  validates :name, uniqueness: true
end
