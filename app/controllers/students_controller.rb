class StudentsController < ApplicationController
	def index
		@students = Student.all
	end

	def show
		@student = Student.find(params[:id])
		@courses = Student.find(params[:id]).courses
	end

	def studentGrades
		@student = Student.find(params[:studentId])
		assignmentList = StudentGrade.where('student_id = ?', params[:studentId]).pluck(:assignment_id)
		@assignments = Assignment.all.where(:id => assignmentList)
		@assignmentGrades = StudentGrade.all.where(:assignment_id => assignmentList)
		@studentGrades = StudentGrade.where(:student_id => params[:studentId])
	end

	def editGrade
		@student = Student.find(params[:studentId])
		@assignment = Assignment.find(StudentGrade.find(params[:studentGradeId]).assignment.id)
		@studentGrade = StudentGrade.find(params[:studentGradeId])
	end

	def updateGrade
		studentGrade = StudentGrade.find(params[:studentGradeId])
		@assignment = Assignment.find(StudentGrade.find(params[:studentGradeId]).assignment.id)
		if studentGrade.update(studentGrade_params)
			redirect_to "/students/#{params[:studentId]}/studentGrades"
		else
			flash[:errors] = studentGrade.errors.full_messages
			redirect_to "/students/#{params[:studentId]}/studentGrades/#{@assignment.id}"
		end
	end

	def edit
		@student = Student.find(params[:id])
	end

	def create
		student = Student.new(student_params)
		if student.save
			redirect_to "/students"
		else
			flash[:errors] = student.errors.full_messages
			redirect_to "/students/new"
		end
	end

	def update
		student = Student.find(params[:id])
		if student.update(student_params)
			redirect_to "/students"
		else
			flash[:errors] = student.errors.full_messages
			redirect_to "/students/#{student.id}/edit"
		end
	end

	def destroy
		student = Student.find(params[:id])
		StudentGrade.where('student_id = ?', params[:id]).destroy_all
		Student.find(params[:id]).studentCourse.destroy_all
		student.destroy
		redirect_to "/students"
	end

	private 
	def student_params
		params.require(:student).permit(:first_name, :last_name)
	end

	private
	def studentGrade_params
		params.require(:studentGrade).permit(:grade, :student_id, :assignment_id)
	end
end
