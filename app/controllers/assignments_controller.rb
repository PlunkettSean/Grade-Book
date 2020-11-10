class AssignmentsController < ApplicationController
def index
		@assignments = Assignment.all
	end

	def new
		@course = Course.find(params[:id])
	end

	def create
		assignment = Assignment.new(assignment_params)
		if assignment.save
			redirect_to "/courses/#{assignment.course_id}/assignments"
		else
			flash[:errors] = assignment.errors.full_messages
			redirect_to "/courses/#{assignment.course_id}/assignments/new"
		end
	end

	def show
		@students = Assignment.find(params[:id]).students
	end 

	def edit
		@assignment = Assignment.find(params[:id])
	end

	def update
		assignment = Assignment.find(params[:id])
		if assignment.update(assignment_params)
			redirect_to "/assignments"
		else
			flash[:errors] = assignment.errors.full_messages
			redirect_to "/assignments/#{assignment.id}/edit"
		end
	end

	def destroy
		assignment = Assignment.find(params[:id])
		assignment.destroy
		redirect_to "/assignments"
	end

	private
	def assignment_params
		params.require(:assignment).permit(:name, :description, :course_id)
	end
end
