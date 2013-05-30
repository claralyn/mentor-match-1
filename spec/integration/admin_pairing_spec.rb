require 'spec_helper'

feature "Admin pairs the student and mentors" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}
	let!(:student){Factory(:student)}

	before do
		ActionMailer::Base.deliveries.clear
	end

	scenario "Admin pairs students together" do
		visit '/'
		find("#Admin").click
		sign_in_as!(admin)
		click_link 'Pair!'
		page.should have_content("Matt Tee")

		# Could only get one item to show in collection item select on students/pair
		select "Butler Price", :from => "student_mentor_id"
		click_button "Submit"
		page.should have_content("Matt Tee had been paired with Butler Price")

		student2 = Student.find(student.id)
		message = "You have been paired with #{student2.mentor.personal_first_name}" +
			" #{student2.mentor.personal_last_name}. You can contact them at #{student2.mentor.personal_email}."
		open_email "student@example.com", with_subject: "Mentor Match Paired"
		current_email.should have_content(message)
	end
end
