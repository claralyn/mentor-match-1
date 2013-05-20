=begin
require 'spec_helper'

feature "Student fills out mentor review" do
	scenario "Student fills out a mentor review" do
		visit ''
		fill_in "personal_first_name", :with => "Tiffany"
		fill_in "personal_last_name", :with => "Rodriguez"
		fill_in "mentor_first_name", :with => "Wheeler"
		fill_in "mentor_last_name", :with => "Ferris"
		choose "rating_availability_10"
		choose "rating_helpfulness_9"
		choose "rating_personality_fit_8"
		choose "rating_overall_experience_8"
		fill_in "mentor_overall_experience", :with => "My experience
																										was awesome"
		fill_in "mentor_system_improvement", :with => "None"
		click_button "Review Mentor"
		page.should have_content("Thanks for your review! " +
															"We hope you enjoyed your " +
															"experience with Codefellows!")
	end
end
=end