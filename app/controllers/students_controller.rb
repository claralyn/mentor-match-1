class StudentsController < ApplicationController

	def index
		@students = Student.all
	end

	def show
	end

	def edit
	end

	def new
		@student = Student.new
	end

	def create
		@student = Student.new(params[:student])
		if @student.save
			flash[:notice] = 'Thank You!'
			redirect_to '/thanks'
		else
			flash[:alert] = 'Sorry, there was problem. ' +
											'Please make sure all field were completed.'
			render :action => "new"
		end
	end

	def thanks
	end

	def update
	end

	def destroy
	end
end
