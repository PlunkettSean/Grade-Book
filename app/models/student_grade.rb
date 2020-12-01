class StudentGrade < ApplicationRecord
  belongs_to :student
  belongs_to :assignment
  validates :grade, :student_id, :assignment_id, presence: true
end
