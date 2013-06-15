require 'spec_helper'

feature "A user logs into the system" do
	let!(:student){Factory(:student)}
	let!(:admin){Factory(:admin_user)}
	let!(:mentor_user){Factory(:confirmed_user)}
	let!(:student_user){Factory(:confirmed_user)}
	let!(:mentor){Factory(:mentor, :user => mentor_user)}
	let!(:student){Factory(:student, :user => student_user)}

	before do
		visit '/'
		click_id "#login"

	end

	scenario "A student logs into their dashboard" do
		fill "Email", student.user.email
		fill "Password", student.user.password
		click_button "Sign in"
		content "Welcome " + student.personal_first_name
		content "Mentor Profiles"
	end

	scenario "A mentor logs into their dashboard" do
		fill "Email", mentor.user.email
		fill "Password", mentor.user.password
		click_button "Sign in"
		# !!!! Dashboard Link needs to be changed for different students and mentors
		content "Welcome " + mentor.personal_first_name
		content "Student Profiles"
	end

	scenario "Admin logs into dashboard" do
		visit '/'
		click_id "#login"
		fill 'Email', admin.email
		fill 'Password', admin.password
		click_button "Sign in"
		content "Signed in successfully."
	end
end
