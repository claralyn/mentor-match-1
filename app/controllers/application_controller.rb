class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize_admin!
    authenticate_user!
    unless current_user.admin
      flash[:notice] = "You must be an admin to do that."
      redirect_to root_path
    end
  end

  def after_sign_in_path_for(users)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => '/')
    if request.referer == sign_in_url
      super
    elsif current_user.admin
      admin_users_path
    elsif current_user.mentor.present?
      mentors_path
    elsif current_user.student.present?
      students_path
    elsif current_user.role == 'mentor'
      new_mentor_path
    elsif current_user.role == 'student'
      new_student_path
    end
  end
end
