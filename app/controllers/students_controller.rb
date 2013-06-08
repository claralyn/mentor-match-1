class StudentsController < ApplicationController
	before_filter :authorize_admin!, except: [:new, :create, :thanks]

	def index
		#need to change this
		@studentnomentors = Student.where("mentor_id is NULL")
		@studentsall  = Student.all
		@mentornostudents = Mentor.find(
																	:all,
																	:joins => "LEFT OUTER JOIN 'students' ON students.mentor_id = mentors.id
																				WHERE students.mentor_id is NULL")
		@mentorsall = Mentor.all
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

	def pair
		@mentors = Mentor.all
		@students = Student.all
    @mentornostudents = Mentor.find(
                                  :all,
                                  :joins => "LEFT OUTER JOIN 'students' ON students.mentor_id = mentors.id
                                        WHERE students.mentor_id is NULL")
	end

	def update
		@student = Student.find(params[:id])
		past_mentor_id = @student.mentor.try(:id)

		if params[:student][:mentor_id] == 'remove'
			@student.update_attributes(mentor_id: nil)
			flash[:notice] = "You've removed the mentor for " + @student.personal_first_name + ' ' + @student.personal_last_name
			redirect_to '/pair'
			return
		end

		if @student.update_attributes(params[:student])
			if @student.mentor_id.present?
				unless past_mentor_id == @student.mentor_id
					flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' had been paired with ' + @student.mentor.personal_first_name + ' ' + @student.mentor.personal_last_name
				end
			else
				flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' has been edited.'
			end
			redirect_to student_path(@student)
		else
			flash[:notice] = 	'There was a problem!' +
												'Please make sure your first name, last name, & email are all filled in.'
			render :action => "edit"
		end
	end

	def paired

		ids = params[:mentor_ids]

		ids.each do |id|

			ids = id.split("-")

			mentorid = ids[0]
			studentid = ids[1]

			@student = Student.find(studentid)

			past_mentor_id = @student.mentor.try(:id)

			if mentorid == 'remove'
				@student.update_attributes(mentor_id: nil)
				if past_mentor_id.present?
					flash[:notice] = "Mentors and mentees have been paired and notifications sent"
				end
				next
			end

			if @student.update_attributes(mentor_id: mentorid)
				if @student.mentor_id.present?
					unless past_mentor_id == @student.mentor_id
						mentor_first = @student.mentor.personal_first_name
						mentor_last = @student.mentor.personal_last_name
						mentor_email = @student.mentor.personal_email

						student_first = @student.personal_first_name
						student_last = @student.personal_last_name
						student_email = @student.personal_email

						if @student.notify == false
							@student.update_attributes(notify: true)
							# Dry Later
							Notifier.notification(@student,
								"Mentor Match Paired",
								"You have been paired with #{mentor_first} #{mentor_last}." +
								" You can contact them at #{mentor_email}.").deliver

							Notifier.notification(@student.mentor,
								"Mentor Match Paired",
								"You have been paired with #{student_first} #{student_last}." +
								" You can contact them at #{student_email}")
						end
					end
					flash[:notice] = "Mentors and mentees have been paired and notifications sent"
				else
					flash[:notice] = "Sorry, there was a problem, and mentors and mentees could not be paired"
				end
			end
		end
		redirect_to students_path
	end


	def destroy
		@student = Student.find(params[:id])
		firstname = @student.personal_first_name
		lastname = @student.personal_last_name
		@student.destroy
		redirect_to students_path, :notice => "#{firstname} #{lastname} has been removed from the database."
	end

	private

	def authorize_admin!
		authenticate_user!
		unless current_user.admin?
			flash[:alert] = "You must be an admin to do that!"
			redirect_to root_path
		end
	end
end
