class StudentObserver < ActiveRecord::Observer

	#sends an automated notification to the student/mentor letting them know to watch their inbox
	def after_create(student)
			Notifier.notification(student,
				"Mentor Match Confirmation",
				"Thanks for filling out your survey. You will be paired soon. Watch out for that email soon.").deliver
	end

	#sends an automated notification to the student and the mentor letting them know they were paired
	def after_update(student)
		if student.mentor_id.presence
			mentor_first = student.mentor.personal_first_name
			mentor_last = student.mentor.personal_last_name
			mentor_email = student.mentor.personal_email

			student_first = student.personal_first_name
			student_last = student.personal_last_name
			student_email = student.personal_email

			# Dry Later
			Notifier.notification(student,
				"Mentor Match Paired",
				"You have been paired with #{mentor_first} #{mentor_last}." +
				" You can contact them at #{mentor_email}.").deliver

			Notifier.notification(student.mentor,
				"Mentor Match Paired",
				"You have been paired with #{student_first} #{student_last}." +
				" You can contact them at #{student_email}")
		end
	end
end