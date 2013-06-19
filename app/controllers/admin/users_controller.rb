class Admin::UsersController < ApplicationController
  before_filter :authorize_admin!

  def index
    #need to change this
    @studentnomentors = Student.joins(:user).where("mentor_id is NULL AND approval = 1")
    @studentsall  = Student.joins(:user).where(:approval, 1)
    @mentornostudents = Mentor.joins(:user).find(
                                  :all,
                                  :joins => "LEFT OUTER JOIN 'students' ON students.mentor_id = mentors.id
                                        WHERE students.mentor_id is NULL AND approval = 1")
    @mentorsall = Mentor.joins(:user).where(:approval, 1)
  end

  def pending_users
    @pending_users = User.where("approval = ?", 0)
  end

  def approve
    approve_ids = params[:approve_ids]
    deny_ids = params[:deny_ids]

    if deny_ids.present?
      deny_ids.each do |id|
        user = User.find(id)
        if user.update_attributes({approval: -1}, as: :admin)
          @@message = "The users have been denied."
        end
      end
    end

    if approve_ids.present?
      approve_ids.each do |id|

        @user = User.find(id)

        if @user.update_attributes({approval: 1}, as: :admin)
            # Dry Later
            if @user.role == 'mentor'
              Notifier.notification(@user.mentor,
                "Mentor Match Approval",
                "You have been approved by Mentor Match." +
                " You may now login and view possible student profiles.").deliver
            else
              Notifier.notification(@user.student,
                "Mentor Match Approval",
                "You have been approved by Mentor Match." +
                " You may now login and view possible mentor profiles.").deliver
            end
            @@message = "The users have been approved."
        else
            @@message = "Sorry, there was a problem and approvals did not go through."
        end
      end
    end
    flash[:notice] = @@message
    redirect_to "/pending"
  end

  def pair
    @mentors = Mentor.all
    @students = Student.all
    @mentornostudents = Mentor.find(
                                  :all,
                                  :joins => "LEFT OUTER JOIN 'students' ON students.mentor_id = mentors.id
                                        WHERE students.mentor_id is NULL")
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
                " You can contact them at #{student_email}").deliver
            end
          end
          flash[:notice] = "Mentors and mentees have been paired and notifications sent"
        else
          flash[:notice] = "Sorry, there was a problem, and mentors and mentees could not be paired"
        end
      end
    end
    redirect_to admin_users_path
  end

 end
