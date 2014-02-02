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
  has_many :lessons
  has_and_belongs_to_many :teachers

  validates :name, :terms, presence: true
end
