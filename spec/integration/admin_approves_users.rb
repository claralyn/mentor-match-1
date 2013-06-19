require 'spec_helper'

feature "an Admin approves different users" do
	let!(:admin){Factory(:admin_user)}
	let!(:user){Factory(:confirmed_user, role: "student")}
	let!(:student){Factory(:student, user: user)}

	scenario "an Admin approves a user" do
		ActionMailer::Base.deliveries.clear
		sign_in_as!(admin)
		click_link "Dashboard"
		click_link 'Approve Users'
		check_me "#approve_ids_"
		click_button 'Submit'
		content "The users have been approved."
		open_email student.personal_email, with_subject: "Mentor Match Approval"
		message = "You have been approved by Mentor Match." +
                " You may now login and view possible mentor profiles"
		current_email.should have_content(message)
		visit '/'
		click_link "Dashboard"
		content student.personal_first_name
	end
end
