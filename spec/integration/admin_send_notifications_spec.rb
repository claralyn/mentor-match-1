require 'spec_helper'

feature "an Admin sends a notification email" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}
	let!(:student){Factory(:student)}

	before do
		ActionMailer::Base.deliveries.clear
		visit '/'
		find "#login"
		sign_in_as!(admin)
		click_link 'Notifications'
		click_link 'Notify'
	end

	scenario "an Admin sends a notification email to an admin" do
		check_me "#mentor_ids_"
		fill 'subject', "Get er done"
		fill 'message', "Really cool message"
		click_button 'Notify'
		open_email "example@example.com", with_subject: "Get er done"
		current_email.should have_content('Really cool message')
	end

	scenario "an Admin sends a notification email to a student" do
		check_me "#student_ids_"
		fill 'subject', "Get er done"
		fill 'message', "Really cool message"
		click_button 'Notify'
		open_email "student@example.com", with_subject: "Get er done"
		current_email.should have_content('Really cool message')
	end
end
