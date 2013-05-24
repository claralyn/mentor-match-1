class MentorsController < ApplicationController
	def new
		@mentor = Mentor.new
		@submittext = 'Submit Profile'
	end

	def create
		@mentor = Mentor.new(params[:mentor])
		if @mentor.save
			flash[:notice] = 'Thank You!'
			redirect_to '/thanks'
		else
			flash[:alert] = 'Sorry, there was a problem. ' +
											'Please make sure all field were completed.'
			render :action => "new"
		end
	end
end
