class MentorsController < ApplicationController
  before_filter :authorize_student!, only: [:show]
  before_filter :authenticate_admin_or_mentor!, only: [:index,
                                                      :edit,
                                                      :update,
                                                      :destroy]
  before_filter :authenticate_user!, only: [:new,
                                            :create]

  def index
    @user = current_user.mentor
    @studentsinterest = Student.where(:goals_companies, @user.career_company_private)
    @students = Student.all
  end

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
    @mentor.user_id = current_user.id

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

    if current_user.mentor == @mentor || current_user.admin?
      if @mentor.update_attributes(params[:mentor])
        if current_user.mentor == @mentor
          message = "Your profile has been edited."
        else
          message = @mentor.personal_first_name + ' ' + @mentor.personal_last_name + "'s profile has been updated"
        end
        flash[:notice] = message
        redirect_to mentor_path(@mentor)
      else
        flash[:notice] =  'There was a problem! ' +
                        'Please make sure your first name, last name, job title, company, company type ' +
                        '& email are all filled in.'
        render :action => "edit"
      end
    else
      flash[:notice] = "You can only edit your own profile."
      redirect_to mentors_path
    end
  end

  def destroy
    @mentor = Mentor.find(params[:id])
    firstname = @mentor.personal_first_name
    lastname = @mentor.personal_last_name
    if current_user.mentor == @mentor
      current_user.destroy
      redirect_to root_path,
        :notice => "You have been deleted from our database"
    else
      @mentor.user.destroy
      redirect_to admin_users_path,
        :notice => "#{firstname} #{lastname} has been removed from the database."
    end
  end

  def rankings
    @rankings = current_user.mentor.rankings.order(:rank)
  end

  private

  def find_mentor
    @mentor = Mentor.find(params[:id])
  end

  def authenticate_admin_or_mentor!
    authenticate_user!
    unless current_user.admin == true || current_user.mentor.present?
      redirect_to root_path
    end
  end

  def authorize_student!
    find_mentor
    authenticate_user!
    unless current_user.admin? || current_user.student.present? || current_user.mentor == @mentor
      flash[:alert] = "You cannot access this page!"
      redirect_to root_path
    end
  end

end
