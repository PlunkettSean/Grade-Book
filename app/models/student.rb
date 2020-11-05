class Student < ApplicationRecord
	has_many :assignments
	has_many :studentCourse
	has_many :courses, through: :studentCourse
	validates :first_name, :last_name, presence: true
end
