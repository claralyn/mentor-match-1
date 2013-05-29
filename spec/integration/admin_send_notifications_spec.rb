require 'spec_helper'

feature "an Admin sends a notification email" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}

	scenario "an Admin sends a notification email" do
		visit '/'
		click_link 'Admin'
		sign_in_as!(admin)
		click_link 'Notifications'
		click_link 'Notify'
		find(:css, "#mentor_ids_").set(true)
		fill_in 'subject', with: "Get er done"
		fill_in 'message', with: "Really cool message"
		click_button 'Notify'
		open_email "example@example.com", with_subject: "Get er done"
		current_email.should have_content('Really cool message')
	end
end