class MentorsController < ApplicationController
  before_filter :authenticate_admin_or_mentor!, except: [:new, :create]

  def index
    @user = current_user.mentor
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
      @mentor.destroy
      redirect_to students_path,
        :notice => "#{firstname} #{lastname} has been removed from the database."
    end
  end

  private

  def authenticate_admin_or_mentor!
    authenticate_user!
    unless current_user.admin == true || current_user.mentor.present?
      redirect_to root_path
    end
  end
end
