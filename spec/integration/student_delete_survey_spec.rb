require 'spec_helper'

feature "An Admin Deletes A Student" do
	let!(:admin){Factory(:admin_user)}
	let!(:student){Factory(:student)}


	scenario "Admin deletes Student from Database" do
		sign_in_as!(admin)
		visit '/'
		click_link "Dashboard"
		page.should have_content("Students that still need mentors")
		click_link "Matt Tee"
		click_link "Delete"
		page.should have_content("Matt Tee has been removed from the database.")
	end
end
