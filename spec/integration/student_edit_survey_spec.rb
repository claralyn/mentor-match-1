require 'spec_helper'


feature "an admin edit a student survey" do
	let(:admin){Factory(:admin_user)}
	let!(:student){Factory(:student)}
	# Code should go up here to login as admin

	scenario "admin edits a student survey" do
		visit '/'
		find("#Admin").click
		sign_in_as!(admin)
		page.should have_content("Students that still need mentors")
		click_link "Matt Tee"
		click_link "Edit"

		# Form to Update
		select 'Ruby on Rails May/June', from: 'student_cf_class'
		fill_in 'personal_first_name', with: "Different"
		fill_in 'personal_last_name', with: "dfd"
		fill_in 'personal_where_you_from', with: "dfd"
		fill_in 'experience_university', with: "Bom"
		fill_in 'experience_degree', with: "Master Ninja"
		fill_in 'experience_other_degree', with: "Seahorse Riding"
		fill_in 'experience_job', with: "Superhero"
		fill_in 'experience_why_codefellows', with: "Because they're awesome"
		fill_in 'experience_project', with: "I once saved Bill Clinton"

		select 'Expert', from: 'student_skills_developer'
		select 'Very Familiar', from: 'student_skills_object'
		select 'Competent', from: 'student_skills_html_css'
		select 'Beginner', from: 'student_skills_javascript'
		select 'Expert', from: 'student_skills_java'
		select 'Competent', from: 'student_skills_cplusplus'
		select 'Expert', from: 'student_skills_c'
		select 'Competent', from: 'student_skills_ruby'
		select 'Expert', from: 'student_skills_python'
		select 'Competent', from: 'student_skills_php'
		select 'Expert', from: 'student_skills_net'
		select 'Expert', from:'student_skills_coffeescript'
		fill_in 'skills_other_coding', with: 'student_skills_other_coding'

		choose 'student_skills_selling_yourself_y'
		select 'Somewhat Familiar', from: 'student_skills_development_familiarity'
		choose 'student_skills_agile_development_experience_y'
		choose 'student_learning_self_taught_y'

		choose 'student_learning_books'
		choose 'student_learning_preference_groups'
		fill_in 'learning_extra_information', with: 'Other info'

		choose 'student_mentor_career_advice_4'
		choose 'student_mentor_skill_development_1'
		choose 'student_mentor_coding_question_tactics_3'
		choose 'student_mentor_soft_skills_1'
		choose 'student_mentor_interview_coaching_4'
		choose 'student_mentor_job_search_5'
		choose 'student_mentor_resume_development_5'
		choose 'student_mentor_github_account_development_3'
		choose 'student_mentor_selling_idea_4'
		select 'Startup', from: 'student_mentor_company_type'
		choose 'student_mentor_gender_n'
		fill_in 'mentor_extra_info', with: 'Other info'

		select 'Startup', from: 'student_goals_company_type'
		fill_in 'goals_after_codefellows', with: 'Go to Disneyland'
		fill_in 'goals_dream_job_title', with: 'Firefighter'
		fill_in 'goals_companies', with: 'Waste Management'
		fill_in 'goals_next_year', with: 'Fly a plane'
		fill_in 'goal_next_4_years', with: 'Brazil'
		choose 'student_goals_stay_seattle_y'
		fill_in 'linked_in', with: 'Linked In'
		fill_in 'goals_extra_info', with: 'extra'

		click_button 'Edit Survey'
		page.should have_content('Different dfd has been edited.')
		page.should_not have_content('Matt Tee')
	end
end
