class RankingsController < ApplicationController
  before_filter :find_student, :except => [ :index,
                                            :update_ranks]

  def index
    @rankings = current_user.mentor.rankings
  end

  def new
    # find the last ranked student
    last_ranking = current_user.mentor.rankings.order("rank").last
    # see if a ranking already exists for this student
    exists_rankings = current_user.mentor.rankings.where(:student_id, @student.id)
    # this is the new rank of the student being added to the rankings
    new_rank =  if last_ranking
                  last_ranking.rank + 1
                else
                  1
                end
    rank = current_user.mentor.rankings.build(student_id: @student.id, rank: new_rank)
    count = Ranking.all.count

    if count > 5
      message = "Sorry, your rankings are full." +
                " Please, delete a ranking first."
    elsif exists_rankings.present?
      message = "You've already added this student to your rankings."
    elsif rank.save
            message = "#{@student.personal_first_name} #{@student.personal_last_name}" +
                      " has been added to your rankings."
    else
      message = "Sorry, there was a problem,
                and your rankings weren't updated."
    end
    flash[:notice] = message
    redirect_to '/rankings'
  end

  def update_ranks
    ranks = JSON.parse(params[:ranking])
    ranks.each do |key, value|
      update_item = Ranking.find(key)
      update_item.rank = value
      update_item.save
    end
    render text: "success", status: 200
  end
  def destroy
    @rank = Ranking.find(params[:id])
    @rank.destroy
    redirect_to '/rankings'
  end

  private

  def find_student
    @student = Student.find(params[:student_id])
  end
end
