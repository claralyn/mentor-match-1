=begin

require 'spec_helper'

feature "Admin pairs the student and mentors" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}
	let!(:student){Factory(:student)}

	before do
		sign_in_as!(admin)
	end

	scenario "Admin pairs students together" do
		visit '/'
		click_link 'Pair!'
		page.should have_content("Matt Tee")
		select "mentee_" + student.id, :from => "Butler Price"
		check_notify_box
		click_button "Submit"
		page.should have_content("Matt Tee had been paired with Butler Price")
	end
end
=end