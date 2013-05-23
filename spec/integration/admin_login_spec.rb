require 'spec_helper'

feature "An admin logs into the system" do
	before do
		Factory(:user, :email => "example@example.com")
	end

	scenario "Admin logs into dashboard" do
		User.find_by_email("example@example.com").confirm!
		User.find_by_email("example@example.com").admin = true
		visit '/'
		click_link 'Admin'
		fill_in 'Email', :with => "example@example.com"
		fill_in 'Password', :with => "password"
		click_button "Sign in"
		page.should have_content("Signed in successfully.")
	end
end