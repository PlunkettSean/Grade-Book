class AssignmentsController < ApplicationController
	def index
		@assignments = Assignment.all
	end

	def new
		@course = Course.find(params[:id])
	end

	def create
		@course = Course.find(params[:id])
		@assignments = Course.find(params[:id]).assignments
		assignment = Assignment.new(assignment_params)
		if @assignments.length >= 10
			flash[:notice] = "Cannot add more assignments"
			redirect_to "/courses/#{assignment.course_id}/assignments/new"
		elsif assignment.save
			studentsInCourse = StudentCourse.where('course_id = ?', params[:id]).pluck(:student_id)
			newestAssignment = Assignment.order("created_at").last
			for student in studentsInCourse
				@emptyGrade = 0.0
				StudentGrade.create(:grade => @emptyGrade.to_f, :assignment_id => newestAssignment.id, :student_id => student)
			end
			redirect_to "/courses/#{assignment.course_id}/assignments"
		else
			flash[:errors] = assignment.errors.full_messages
			redirect_to "/courses/#{assignment.course_id}/assignments/new"
		end
	end

	def show
		@course = Course.find(params[:id])
		@assignment = Assignment.find(params[:assignmentId])
		@students = Course.find(params[:id]).students
		@studentGrade = StudentGrade.where('assignment_id = ?', params[:assignmentId])

		assignmentGrades = StudentGrade.where('assignment_id = ?', params[:assignmentId]).pluck(:grade) # [100.0,100.0,1.00,0.0,0.0]
		sum = assignmentGrades.sum(0.0)
		@max = assignmentGrades.max()
		@min = assignmentGrades.min()
		@average = sum / assignmentGrades.length

	end 

	def editGrade
		@course = Course.find(params[:id])
		@student = Student.find(params[:studentId])
		@assignment = Assignment.find(params[:assignmentId])
		@studentGrade = StudentGrade.find_by(:student_id => params[:studentId], :assignment_id => params[:assignmentId])
	end

	def updateGrade
		studentGrade = StudentGrade.find(params[:studentGradeId])
		@assignment = Assignment.find(params[:assignmentId])
		if studentGrade.update(studentGrade_params)
			redirect_to "/courses/#{@assignment.course_id}/assignments/#{params[:assignmentId]}"
		else
			flash[:errors] = studentGrade.errors.full_messages
			redirect_to "/courses/#{@assignment.course_id}/assignments/#{params[:assignmentId]}/grade/#{params[:studentId]}/#{params[:studentGradeId]}"
		end
	end

	def edit
		@courseid = params[:id]
		@assignment = Assignment.find(params[:assignmentId])
	end

	def update
		assignment = Assignment.find(params[:assignmentId])
		if assignment.update(assignment_params)
			redirect_to "/courses/#{assignment.course_id}/assignments"
		else
			flash[:errors] = assignment.errors.full_messages
			redirect_to "/courses/#{assignment.course_id}/assignments/#{params[:assignmentId]}/edit"
		end
	end

	def destroy
		assignment = Assignment.find(params[:assignmentId])
		StudentGrade.where('assignment_id = ?', params[:assignmentId]).destroy_all
		assignment.destroy
		redirect_to "/courses/#{assignment.course_id}/assignments"
	end

	private
	def assignment_params
		params.require(:assignment).permit(:name, :description, :course_id)
	end

	private
	def studentGrade_params
		params.require(:studentGrade).permit(:grade, :student_id, :assignment_id)
	end
end
