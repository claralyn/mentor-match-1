class NotificationsController < ApplicationController

	def index
		@notifications = Notification.all
	end

	def new
		@notification = Notification.new
	end

	def show
		@notification = Notification.find(params[:id])
	end

	def create

		@subject = params[:notification][:subject]
		@message = params[:notification][:message]

		if params[:student_ids].present?
			student_ids = params[:student_ids].collect{|id|
				id.to_i}

			student_ids.each do |id|
				@student = Student.find(id)
				Notifier.notification(@student,
											@subject,
											@message).deliver
				@notification = Notification.create(
						subject: @subject,
						message: @message,
						receiver_id: id,
						receiver_type: "student")
			end
		end

		if params[:mentor_ids].present?

			mentor_ids = params[:mentor_ids].collect{|id|
				id.to_i}


			mentor_ids.each do |id|
				@mentor = Mentor.find(id)
				Notifier.notification(@mentor,
											@subject,
											@message).deliver

				@notification = Notification.create(
						subject: @subject,
						message: @message,
						receiver_id: id,
						receiver_type: "mentor")
			end
		end

		flash[:notice] = "A notification has been sent to that user"
		redirect_to notifications_path
	end
end