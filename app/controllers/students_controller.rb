class StudentsController < ApplicationController
	def index
		@students = Student.all
	end

	def show
		@courses = Student.find(params[:id]).courses
	end

	def edit
		@student = Student.find(params[:id])
	end

	def create
		student = Student.new(student_params)
		if student.save
			redirect_to "/student"
		else
			flash[:errors] = student.errors.full_messages
			redirect_to "/student/new"
		end
	end

	def update
		student = Student.find(params[:id])
		if student.update(student_params)
			redirect_to "/students"
		else
			flash[:errors] = studentstudent.errors.full_messages
			redirect_to "/students/#{student.id}/edit"
		end
	end

	private 
	def student_params
		params.require(:student).permit(:first_name, :last_name)
	end
end
