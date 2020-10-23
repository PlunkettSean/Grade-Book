class Course < ApplicationRecord
	validates :title, :professor, :room, presence: true
end
