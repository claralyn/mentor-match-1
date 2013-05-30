class StudentsController < ApplicationController

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
		@submittext = "Edit Survey"
	end

	def new
		@student = Student.new
		@submittext = "Submit Survey"
	end

	def create
		@student = Student.new(params[:student])
		if @student.save
			redirect_to '/thanks'
		else
			flash[:alert] = 'Sorry, there was a problem. ' +
											'Please make sure all field were completed.'
			render :action => "new"
		end
	end

	def thanks
	end

	def pair
		@mentors = Mentor.all
		@students = Student.all
	end

	def update
		@student = Student.find(params[:id])
		past_mentor_id = @student.mentor.try(:id)

		if @student.update_attributes(params[:student])
			if @student.mentor_id
				unless past_mentor_id == @student.mentor_id
					flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' had been paired with ' + @student.mentor.personal_first_name + ' ' + @student.mentor.personal_last_name				end
			else
				flash[:notice] = @student.personal_first_name + ' ' + @student.personal_last_name + ' has been edited.'
			end
			redirect_to student_path(@student)
		else
			flash[:notice] = 'There was a problem!'
			render :action => "edit"
		end
	end

	def destroy
		@student = Student.find(params[:id])
		firstname = @student.personal_first_name
		lastname = @student.personal_last_name
		@student.destroy
		redirect_to students_path, :notice => "#{firstname} #{lastname} has been removed from the database."
	end
end
