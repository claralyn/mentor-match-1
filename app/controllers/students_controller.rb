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
			flash[:alert] = 'Sorry, there was a problem. ' +
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
