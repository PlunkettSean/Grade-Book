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
		@course = Course.find(params[:id])
	end 

	def addStudents
		@course = Course.find(params[:id])
		studentsInCourse = StudentCourse.where('course_id = ?', params[:id]).pluck(:student_id) # integer array
		@students = Student.all.where.not(id: studentsInCourse)
	end

	def createStudentCourse
		course = Course.find(params[:id])
		@students = Course.find(params[:id]).students
		studentCourse = StudentCourse.new(studentCourse_params)
		if @students.length >= 10
			flash[:notice] = "Class is full. Can not add more Students"
			redirect_to "/courses/#{course.id}/students/addStudents"
		elsif studentCourse.save
			assignmentsInCourse = Assignment.where('course_id = ?', params[:id]).pluck(:id)
			newestStudent = StudentCourse.order("created_at").last
			for assignment in assignmentsInCourse
				@emptyGrade = 0.0
				StudentGrade.create!(:grade => @emptyGrade.to_f, :assignment_id => assignment, :student_id => newestStudent.student_id)
			end
			redirect_to "/courses/#{course.id}/students"
		else
			flash[:errors] = studentCourse.errors.full_messages
			redirect_to "/courses/#{course.id}/students/addStudents"
		end
	end

	def assignments
		@assignments = Course.find(params[:id]).assignments
		@course = Course.find(params[:id])
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
		@course = Course.find(params[:id])
		Course.find(params[:id]).assignments.destroy_all
		Course.find(params[:id]).studentCourse.destroy_all
		@course.destroy
		redirect_to "/courses"
	end

	private
	def course_params
		params.require(:course).permit(:title, :professor, :room)
	end

	private
	def studentCourse_params
		params.require(:studentCourse).permit(:student_id, :course_id)
	end
end

