require 'spec_helper'

feature "an Admin sends a notification email" do
	let!(:admin){Factory(:admin_user)}

	scenario "an Admin sends a notification email" do
		visit '/'
		click_link 'Admin'
		sign_in_as!(admin)
		click_link 'Notifications'
		click_link 'Notify'
		fill_in 'subject', with: "Get er done"
		fill_in 'message', with: "Really cool message"
		click_button 'Notify'
		page.should have_content('Really cool message')
	end
end