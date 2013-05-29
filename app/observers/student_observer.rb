class StudentObserver < ActiveRecord::Observer
	def after_create(student)
			Notifier.notification(student,
				"Mentor Match Confirmation",
				"Thanks for filling out your survey. You will be paired soon. Watch out for that email soon.").deliver
	end
end