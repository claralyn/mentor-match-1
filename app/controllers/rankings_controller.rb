class RankingsController < ApplicationController
  before_filter :find_student, :except => [:index]

  def index
    @rankings = current_user.mentor.rankings
  end

  def new
    @rank = Ranking.new
  end

  def create
    # define selected rank number
    @rank_number = params[:ranking][:rank]

    #find if the rank number's current position is filled
    @current_position = current_user.mentor.rankings.where("rank = ?", @rank_number)


    # if there exists a current position
    if @current_position.present?

      # checks whether the current position is already set to this student
      @selected_current_rank = current_user.mentor.rankings.where("student_id = ? AND rank = ?", @student.id, @rank)

      # if the position is already current, direct to current page
      if @selected_current_rank
        message =  @student.personal_first_name + ' ' + @student.personal_last_name + " is already part of your rankings."
        flash[:notification] = message
        redirect_to '/rankings'
        return
      end


      # old_ranking = current_user.mentor.rankings.where("rank >= ?", @rank)

      # old_ranking.each do |oldRank|

      # Sets position to the current rank resource
      position = @current_position

      #sets rank to current rank
      rank_number = @rank_number

        # Cycle through positions until the next position is blank or the rank_number is larger than 5
        until position.blank || rank_number > 5

          # set the new rank number
          rank_number = @rank + 1

          # if the new rank number is 6, then destroy it
          if rank_number == 6

            position.destroy

          else

            # sets the next position
            next_position = current_user.mentor.rankings.where("rank = ?", rank_number)

            # Updates current position with new rank number
            position.update_attributes(rank: rank_number)

            #sets the position to the next position
            position = next_position

          end

      end

    end
    @ranking = @student.rankings.build(rank: @rank,
                mentor_id: current_user.mentor.id)

    if @ranking && @ranking.save
      message = @student.personal_first_name + ' ' + @student.personal_last_name + " has been adding to your rankings"
    else
      message = "Your rankings were not updated"
    end
    flash[:notification] = message
    redirect_to '/rankings'
  end

  def update
  end

  def destroy
    @rank = params[:id]
    @rank.destroy
  end

  private

  def find_student
    @student = Student.find(params[:student_id])
  end
end
