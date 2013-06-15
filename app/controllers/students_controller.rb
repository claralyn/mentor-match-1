class StudentsController < ApplicationController
  before_filter :authorize_mentor!, only: [:show]
	before_filter :authorize_student!, only: [:index,
																						:edit,
																						:update,
																						:destroy]
	def index
    @user = current_user.student
    @mentors = Mentor.all
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
			redirect_to '/thanks'
		else
			#change flash message if email is not unique
			flash[:alert] = 'Sorry, there was a problem. ' +
											'Please make sure your first name, last name, & email are all filled in.'
			render :action => "new"
		end
	end

	def thanks
	end

	def update
		@student = Student.find(params[:id])

		if current_user.student == @student || current_user.admin?
			if @student.update_attributes(params[:student])
				if current_user.student == @student
					message = "Your profile has been edited."
				else
					message = @student.personal_first_name + ' ' + @student.personal_last_name + ' has been edited.'
				end
				flash[:notice] = message
				redirect_to student_path(@student)
			else
				flash[:notice] = 	'There was a problem!' +
													'Please make sure your first name, last name, & email are all filled in.'
				render :action => "edit"
			end
		else
			flash[:notice] = "You can only edit your own profile."
			redirect_to students_path
		end
	end

	def destroy
		@student = Student.find(params[:id])
		firstname = @student.personal_first_name
		lastname = @student.personal_last_name
		if current_user.student == @student
			current_user.student.destroy
 			flash[:notice] = "You have been deleted from our database."
			redirect_to root_path
		else
			@student.user.destroy
			flash[:notice] = "#{firstname} #{lastname} has been removed from the database."
			redirect_to admin_users_path
		end
	end

	private

	def find_student
		@student = Student.find(params[:id])
	end
	def authorize_student!
		authenticate_user!
		unless current_user.admin? || current_user.student.present?
			flash[:alert] = "You must be a student or admin to do that!"
			redirect_to root_path
		end
	end

  def authorize_mentor!
  	find_student
    authenticate_user!
    unless current_user.admin? || current_user.mentor.present? || current_user.student == @student
			flash[:alert] = "You must be a mentor or admin to do that!"
      redirect_to root_path
    end
  end

end
