class NotificationsController < ApplicationController

	def index
		@notifications = Notification.all
	end

	def new
		@notification = Notification.new
	end

	def create
		@notification = Notification.new(params[:notification])
		if @notification.save
			flash[:notice] = "A notification has been sent to that user"
			redirect_to notifications_path
		else
			flash[:alert] = "Sorry, there was a problem and your notification wasn't sent"
			render :action => "new"
		end
	end
end