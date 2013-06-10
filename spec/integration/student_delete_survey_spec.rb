require 'spec_helper'

feature "An Admin Deletes A Student" do
	let!(:admin){Factory(:admin_user)}
	let!(:student){Factory(:student)}


	scenario "Admin deletes Student from Database" do
		sign_in_as!(admin)
		visit '/'
		click_link "Dashboard"
		content "Students that still need mentors"
		click_link "Matt Tee"
		click_link "Delete"
		content "Matt Tee has been removed from the database."
	end

=begin
	scenario "a Student delete their profile"
		sign_in_as!(student)
		visit '/'
		click_link "Delete Your Profile"
		content "You have been deleted from our database"
=end
end
