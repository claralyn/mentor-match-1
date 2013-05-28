class StudentObserver < ActiveRecord::Observer
	def after_update(student)
		if student.mentor_id
			Notifier.notify(student, mentor).deliver
		end
	end
end

class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
   (comment.ticket.watchers - [comment.user]).each do |user|
      Notifier.comment_updated(comment, user).deliver
end end
end