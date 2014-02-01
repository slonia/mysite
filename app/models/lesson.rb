class Lesson < ActiveRecord::Base
  belongs_to :subject
  belongs_to :teacher
  belongs_to :room
end
