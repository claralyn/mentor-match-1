=begin
require 'spec_helper'


feature "an admin edit a student survey" do
	let!(:admin){Factory(:admin_user)}
	let!(:student){Factory(:student)}
	# Code should go up here to login as admin

	scenario "admin edits a student survey" do
		visit '/'
		page.should have_content("Students that still need mentors")
		click_link "Matt Tee"

		# Form to Update
		fill_in 'personal_first_name', :with => "Different"
		fill_in 'personal_last_name', :with => "dfd"
		fill_in 'personal_where_you_from', :with => "dfd"
		choose 'experience_university_no'
		fill_in 'experience_degree', :with => "Master Jedi"
		fill_in 'experience_other_degree', :with => "Sea Riding"
		fill_in 'experience_job', :with => "Super"
		fill_in 'experience_why_codefellows', :with => "Because they awesome"
		fill_in 'experience_project', :with => "I once saved George Bush"

		select 'skills_developer', :from => 'Competent'
		select 'skills_html_css', :from => 'Expert'
		select 'skills_javascript', :from => 'Expert'
		select 'skills_java', :from => 'Competent'
		select 'skills_cplusplus', :from => 'Expert'
		select 'skills_c', :from => 'Competent'
		select 'skills_ruby', :from => 'Expert'
		select 'skills_python', :from => 'Expert'
		select 'skills_php', :from => 'Expert'
		select 'skills_net', :from => 'Beginner'
		select 'skills_coffescript', :from =>'Expert'
		select 'skills_other_coding', :from => 'Expert'

		choose 'skills_selling_yourself_no'
		select 'skills_development_familiarity', :with => 'Familiar'
		choose 'skills_agile_development_experience_no'
		choose 'learning_self_taught_no'

		choose 'learning_class'
		choose 'learning_alone'
		fill_in 'learning_extra_information', :with => 'Other'

		choose 'mentor_skill_development_1'
		choose 'mentor_coding_question_tactics_1'
		choose 'mentor_soft_skills_1'
		choose 'mentor_interview_coaching_1'
		choose 'mentor_job_search_1'
		choose 'mentor_resume_development_1'
		choose 'mentor_github_account_development_1'
		choose 'mentor_selling_idea_1'
		choose 'mentor_company_type_startup_1'
		choose 'mentor_gender_nopreference'
		fill_in 'mentor_extra_info', :with => 'Other'

		select 'goals_company_type', :from => 'Large Company'
		fill_in 'goals_after_codefellows', :with => 'Go to Space'
		fill_in 'goals_dream_job_title', :with => 'Police Officer'
		fill_in 'goals_companies', :with => 'Pirates'
		fill_in 'goals_next_year', :with => 'Visit Europe'
		fill_in 'goal_next_4_years', :with => 'dsf'
		choose 'goals_stay_seattle_no'
		fill_in 'linked_in', :with => 'Linked Out'
		fill_in 'goals_extra_info', :with => 'extraafd'

		click_button 'Edit Survey'
		page.should have_content('Different dfd has been edited.')
		page.should_not have_content('Matt Tee')
	end
end
=end