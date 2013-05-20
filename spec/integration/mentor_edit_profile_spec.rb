=begin

require 'spec_helper'

feature "An Admin Edits a Mentor Profile" do
	let!(:admin){Factory(:admin_user)}
	let!(:mentor){Factory(:mentor)}

	scenario "Admin deletes Mentor from Database" do
		sign_in_as!(admin)
		visit '/'
		page.should have_content("Mentors that still need mentees")
		click_link "Butler Price"
		click_link "Edit"

		# Form that needs to be changed
		fill_in "personal_first_name", :with => "John"
		fill_in "personal_last_name", :with => "Thomas"

		fill_in "career_information", :with => "Some Information"
		fill_in "career_job_title", :with => "CEO"
		fill_in "career_company_private", :with => "Octomania"

		choose 'experience_university_yes'
		fill_in 'experience_degree', :with => "Master Ninja"
		fill_in 'experience_other_degree', :with => "Seahorse Riding"
		fill_in 'experience_job', :with => "Superhero"
		fill_in 'experience_project', :with => "I once saved Bill Clinton"

		select 'mentee_skills_developer', :from => 'Expert'
		select 'mentee_skills_html_css', :from => 'Competent'
		select 'mentee_skills_javascript', :from => 'Beginner'
		select 'mentee_skills_java', :from => 'Expert'
		select 'mentee_skills_cplusplus', :from => 'Competent'
		select 'mentee_skills_c', :from => 'Expert'
		select 'mentee_skills_ruby', :from => 'Competent'
		select 'mentee_skills_python', :from => 'Beginner'
		select 'mentee_skills_php', :from => 'Competent'
		select 'mentee_skills_net', :from => 'Expert'
		select 'mentee_skills_coffescript', :from =>'Beginner'
		select 'mentee_skills_other_coding', :from => 'Competent'

		choose 'skills_development_10'
		choose 'skills_coding_question_tactics_9'
		choose 'skills_soft_skills_8'
		choose 'skills_interview_coaching_7'
		choose 'mentor_job_search_5'
		choose 'skills_resume_development_8'
		choose 'skills_github_account_development_6'
		choose 'skills_selling_idea_4'
		choose 'skills_company_type_startup_9'
		choose 'skills_gender_nopreference'
		fill_in 'skills_extra_info', :with => 'Other info'

		choose 'skills_selling_yourself_yes'
		select 'skills_development_familiarity', :with => 'Somewhat Familiar'
		choose 'skills_agile_development_experience_yes'


		fill_in "mentee_other_info", :with => "Other cool info"

		click_button "Update Profile"
		page.should have_content("John Thomas's profile has been updated")
		page.should have_content("John Thomas")
		page.should_not have_content("Butler Price")
	end
end

=end