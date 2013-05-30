require 'spec_helper'

feature "a student fills out survey" do
	before do
		ActionMailer::Base.deliveries.clear
	end

	scenario "student fills out survey" do
		visit '/'
		click_link 'Student'
		select 'Ruby on Rails June', from: 'student_cf_class'
		fill_in 'personal_first_name', with: "Fud"
		fill_in 'personal_last_name', with: "Helser"
		fill_in 'personal_email', with: "example@example.com"
		fill_in 'personal_where_you_from', with: "Alaska"
		choose 'student_experience_university_y'
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
		fill_in 'skills_other_coding', with: "Coolio awesome faced man"

		choose 'student_skills_selling_yourself_y'
		select 'Somewhat Familiar', from: 'student_skills_development_familiarity'
		choose 'student_skills_agile_development_experience_y'
		choose 'student_learning_self_taught_y'

		choose 'student_learning_books'
		choose 'student_learning_preference_groups'
		fill_in 'learning_extra_information', with: 'Other info'

		choose 'student_mentor_career_advice_9'
		choose 'student_mentor_skill_development_10'
		choose 'student_mentor_coding_question_tactics_9'
		choose 'student_mentor_soft_skills_8'
		choose 'student_mentor_interview_coaching_7'
		choose 'student_mentor_job_search_5'
		choose 'student_mentor_resume_development_8'
		choose 'student_mentor_github_account_development_6'
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

		click_button 'Submit Survey'
		page.should have_content('Thank You!')

		open_email "example@example.com", with_subject: 'Mentor Match Confirmation'
		current_email.should have_content('Thanks for filling out your survey.' +
			' You will be paired soon. Watch out for that email soon.')

	end
end