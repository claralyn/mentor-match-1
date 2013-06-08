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
		select "Butler Price", :from => "mentor_ids[]"
		click_button "Pair"
		page.should have_content("Matt Tee had been paired with Butler Price")

		student2 = Student.find(student.id)
		message =  "Mentors and mentees have been paired and notifications sent"
		open_email "student@example.com", with_subject: "Mentor Match Paired"
		current_email.should have_content(message)
	end
end
