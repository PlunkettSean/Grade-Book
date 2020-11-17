class CoursesController < ApplicationController
def index
		@courses = Course.all
	end

	def new
	end

	def create
		course = Course.new(course_params)
		if course.save
			redirect_to "/courses"
		else
			flash[:errors] = course.errors.full_messages
			redirect_to "/courses/new"
		end
	end

	def students
		@students = Course.find(params[:id]).students
	end 

	def assignments
		@assignments = Course.find(params[:id]).assignments
	end

	def edit
		@course = Course.find(params[:id])
	end

	def update
		course = Course.find(params[:id])
		if course.update(course_params)
			redirect_to "/courses"
		else
			flash[:errors] = course.errors.full_messages
			redirect_to "/courses/#{course.id}/edit"
		end
	end

	def destroy
		@assignments = Course.find(params[:id])
		@assignments.destroy
		redirect_to "/courses/new"
	end

	private
	def course_params
		params.require(:course).permit(:title, :professor, :room)
	end
end

