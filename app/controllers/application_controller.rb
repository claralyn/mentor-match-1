class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(users)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => '/')
    if request.referer == sign_in_url
      super
    elsif current_user.mentor.present?
      mentors_path
    else
      students_path
    end
  end
end
