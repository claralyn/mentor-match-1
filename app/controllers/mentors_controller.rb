class MentorsController < ApplicationController
	before_filter :authenticate_user!, except: [:new, :create]

	def new
		@mentor = Mentor.new
	end

	def show
		@mentor = Mentor.find(params[:id])
	end

	def edit
		@mentor = Mentor.find(params[:id])
	end

	def create
		@mentor = Mentor.new(params[:mentor])
		if @mentor.save
			redirect_to '/thanks'
		else
			flash[:alert] = 'Sorry, there was a problem. ' +
											'Please make sure your first name, last name, job title, company, company type ' +
											'& email are all filled in.'
			render :action => "new"
		end
	end

	def update
		@mentor = Mentor.find(params[:id])
		if @mentor.update_attributes(params[:mentor])
			flash[:notice] = @mentor.personal_first_name + ' ' + @mentor.personal_last_name + "'s profile has been updated"
			redirect_to mentor_path(@mentor)
		else
			flash[:notice] = 	'There was a problem! ' +
											'Please make sure your first name, last name, job title, company, company type ' +
											'& email are all filled in.'
			render :action => "edit"
		end
	end

	def destroy
		@mentor = Mentor.find(params[:id])
		firstname = @mentor.personal_first_name
		lastname = @mentor.personal_last_name
		@mentor.destroy
		redirect_to students_path, :notice => "#{firstname} #{lastname} has been removed from the database."
	end
end
