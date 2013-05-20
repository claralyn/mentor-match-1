=begin
require 'spec_helper'

feature "a student fills out survey" do
	scenario "student fills out survey" do
		visit '/'
		click_link 'Student'
		fill_in 'personal_first_name', :with => "Fud"
		fill_in 'personal_last_name', :with => "Helser"
		fill_in 'personal_where_you_from', :with => "Alaska"
		choose 'experience_university_yes'
		fill_in 'experience_degree', :with => "Master Ninja"
		fill_in 'experience_other_degree', :with => "Seahorse Riding"
		fill_in 'experience_job', :with => "Superhero"
		fill_in 'experience_why_codefellows', :with => "Because they're awesome"
		fill_in 'experience_project', :with => "I once saved Bill Clinton"

		select 'skills_developer', :from => 'Expert'
		select 'skills_html_css', :from => 'Competent'
		select 'skills_javascript', :from => 'Beginner'
		select 'skills_java', :from => 'Expert'
		select 'skills_cplusplus', :from => 'Competent'
		select 'skills_c', :from => 'Expert'
		select 'skills_ruby', :from => 'Competent'
		select 'skills_python', :from => 'Beginner'
		select 'skills_php', :from => 'Competent'
		select 'skills_net', :from => 'Expert'
		select 'skills_coffescript', :from =>'Beginner'
		select 'skills_other_coding', :from => 'Competent'

		choose 'skills_selling_yourself_yes'
		select 'skills_development_familiarity', :with => 'Somewhat Familiar'
		choose 'skills_agile_development_experience_yes'
		choose 'learning_self_taught_yes'

		choose 'learning_books'
		choose 'learning_groups'
		fill_in 'learning_extra_information', :with => 'Other info'

		choose 'mentor_skill_development_10'
		choose 'mentor_coding_question_tactics_9'
		choose 'mentor_soft_skills_8'
		choose 'mentor_interview_coaching_7'
		choose 'mentor_job_search_5'
		choose 'mentor_resume_development_8'
		choose 'mentor_github_account_development_6'
		choose 'mentor_selling_idea_4'
		choose 'mentor_company_type_startup_9'
		choose 'mentor_gender_nopreference'
		fill_in 'mentor_extra_info', :with => 'Other info'

		select 'goals_company_type', :from => 'Startup'
		fill_in 'goals_after_codefellows', :with => 'Go to Disneyland'
		fill_in 'goals_dream_job_title', :with => 'Firefighter'
		fill_in 'goals_companies', :with => 'Waste Management'
		fill_in 'goals_next_year', :with => 'Fly a plane'
		fill_in 'goal_next_4_years', :with => 'Brazil'
		choose 'goals_stay_seattle_yes'
		fill_in 'linked_in', :with => 'Linked In'
		fill_in 'goals_extra_info', :with => 'extra'

		click_button 'Submit Survey'
		page.should have_content('Thank You!')
	end
end

=end