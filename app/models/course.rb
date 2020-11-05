class Course < ApplicationRecord
	has_many :assignments
	has_many :studentCourse
	has_many :students, through: :studentCourse
	validates :title, :professor, :room, presence: true
end
