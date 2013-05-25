require 'spec_helper'

feature "An Admin Deletes A Mentor" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}


	scenario "Admin deletes Mentor from Database" do
		sign_in_as!(admin)
		page.should have_content("Mentors that still need mentees")
		click_link "Butler Price"
		click_link "Delete"
		page.should have_content("Butler Price has been removed from the database.")
	end

	scenario "If not an Admin, Mentors not Shown" do
		sign_in_as!(admin)
		click_link 'Sign Out'
		visit '/'
		page.should_not have_content("Mentors that still need mentees")
	end
end