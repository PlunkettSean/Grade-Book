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

	def show
		@students = Course.find(params[:id]).students
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
		course = Course.find(params[:id])
		course.destroy
		redirect_to "/courses"
	end

	private
	def course_params
		params.require(:course).permit(:title, :professor, :room)
	end
end

