require 'spec_helper'

feature "Admin pairs the student and mentors" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}
	let!(:student){Factory(:student)}

	scenario "Admin pairs students together" do
		visit '/'
		click_link 'Admin'
		sign_in_as!(admin)
		click_link 'Pair!'
		page.should have_content("Matt Tee")

		# Could only get one item to show in collection item select on students/pair
		select "Price", :from => "mentee_#{student.id}"
		click_button "Submit"
		page.should have_content("Matt Tee had been paired with Butler Price")
	end
end