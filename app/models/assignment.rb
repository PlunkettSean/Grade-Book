class Assignment < ApplicationRecord
  belongs_to :course
  validates :name, :description, :course_id, presence: true
end
