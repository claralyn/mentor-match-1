class StudentsController < ApplicationController

	def index
		#need to change this
		@studentnomentors = Student.all
		@studentwithmentors  = Student.all
	end

	def show
		@student = Student.find(params[:id])
	end

	def edit
		@student = Student.find(params[:id])
		@submittext = "Edit Survey"
	end

	def new
		@student = Student.new
		@submittext = "Submit Survey"
	end

	def create
		@student = Student.new(params[:student])
		if @student.save
			flash[:notice] = 'Thank You!'
			redirect_to '/thanks'
		else
			flash[:alert] = 'Sorry, there was a problem. ' +
											'Please make sure all field were completed.'
			render :action => "new"
		end
	end

	def thanks
	end

	def update
		@student = Student.find(params[:id])
		if @student.update_attributes(params[:student])
			flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' has been edited.'
			redirect_to students_path
		else

		end
	end

	def destroy
	end
end
