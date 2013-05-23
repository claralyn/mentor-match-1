require 'spec_helper'


feature "an admin edit a student survey" do
	let(:admin){Factory(:admin_user)}
	let!(:student){Factory(:student)}
	# Code should go up here to login as admin

	scenario "admin edits a student survey" do
		visit '/'
		click_link 'Admin'
		sign_in_as!(admin)
		page.should have_content("Students that still need mentors")
		click_link "Matt Tee"

		# Form to Update
		select 'Ruby on Rails May/June', from: 'cf_class'
		fill_in 'personal_first_name', with: "Different"
		fill_in 'personal_last_name', with: "dfd"
		fill_in 'personal_where_you_from', with: "dfd"
		choose 'experience_university_y'
		fill_in 'experience_degree', with: "Master Ninja"
		fill_in 'experience_other_degree', with: "Seahorse Riding"
		fill_in 'experience_job', with: "Superhero"
		fill_in 'experience_why_codefellows', with: "Because they're awesome"
		fill_in 'experience_project', with: "I once saved Bill Clinton"

		select 'Expert', from: 'skills_developer'
		select 'Expert', from: 'skills_object'
		select 'Competent', from: 'skills_html_css'
		select 'Beginner', from: 'skills_javascript'
		select 'Expert', from: 'skills_java'
		select 'Competent', from: 'skills_cplusplus'
		select 'Expert', from: 'skills_c'
		select 'Competent', from: 'skills_ruby'
		select 'Expert', from: 'skills_python'
		select 'Competent', from: 'skills_php'
		select 'Expert', from: 'skills_net'
		select 'Expert', from:'skills_coffeescript'
		select 'Competent', from: 'skills_other_coding'

		choose 'skills_selling_yourself_y'
		select 'Somewhat Familiar', from: 'skills_development_familiarity'
		choose 'skills_agile_development_experience_y'
		choose 'learning_self_taught_y'

		choose 'learning_books'
		choose 'learning_preference_groups'
		fill_in 'learning_extra_information', with: 'Other info'

		choose 'mentor_career_advice_9'
		choose 'mentor_skill_development_10'
		choose 'mentor_coding_question_tactics_9'
		choose 'mentor_soft_skills_8'
		choose 'mentor_interview_coaching_7'
		choose 'mentor_job_search_5'
		choose 'mentor_resume_development_8'
		choose 'mentor_github_account_development_6'
		choose 'mentor_selling_idea_4'
		select 'Startup', from: 'mentor_company_type'
		choose 'mentor_gender_n'
		fill_in 'mentor_extra_info', with: 'Other info'

		select 'Startup', from: 'goals_company_type'
		fill_in 'goals_after_codefellows', with: 'Go to Disneyland'
		fill_in 'goals_dream_job_title', with: 'Firefighter'
		fill_in 'goals_companies', with: 'Waste Management'
		fill_in 'goals_next_year', with: 'Fly a plane'
		fill_in 'goal_next_4_years', with: 'Brazil'
		choose 'goals_stay_seattle_y'
		fill_in 'linked_in', with: 'Linked In'
		fill_in 'goals_extra_info', with: 'extra'

		click_button 'Edit Survey'
		page.should have_content('Different dfd has been edited.')
		page.should_not have_content('Matt Tee')
	end
end