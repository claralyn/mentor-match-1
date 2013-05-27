require 'spec_helper'

feature "A mentor adds his profile information" do
	scenario "Mentor adds his profile information" do
		visit '/'
		click_link "Mentor"
		fill_in "personal_first_name", :with => "John"
		fill_in "personal_last_name", :with => "Thomas"
		fill_in "personal_why_mentor", :with => "Because I'm great"
		fill_in "personal_knowledge_impart", :with => "Great knowledge"

		fill_in "career_information", :with => "Some Information"
		fill_in "career_job_title", :with => "CEO"
		fill_in "career_company_private", :with => "Octomania"
		select "Startup", :from => "mentor_career_company_type"

		choose 'mentor_experience_university_y'
		fill_in 'experience_degree', :with => "Master Ninja"
		fill_in 'experience_other_degree', :with => "Seahorse Riding"

		select 'Very Able', :from => 'mentor_mentee_skills_developer'
		select 'Somewhat Able', :from => 'mentor_mentee_skills_html_css'
		select 'Not Able', :from => 'mentor_mentee_skills_javascript'
		select 'Very Able', :from => 'mentor_mentee_skills_java'
		select 'Somewhat Able', :from => 'mentor_mentee_skills_cplusplus'
		select 'Very Able', :from => 'mentor_mentee_skills_c'
		select 'Somewhat Able', :from => 'mentor_mentee_skills_ruby'
		select 'Not Able', :from => 'mentor_mentee_skills_python'
		select 'Not Able', :from => 'mentor_mentee_skills_php'
		select 'Very Able', :from => 'mentor_mentee_skills_net'
		select 'Not Able', :from =>'mentor_mentee_skills_coffeescript'
		fill_in 'mentee_skills_other_coding', :with => "asdfdas"

		choose 'mentor_skills_career_advice_9'
		choose 'mentor_skills_development_10'
		choose 'mentor_skills_coding_question_tactics_9'
		choose 'mentor_skills_soft_skills_8'
		choose 'mentor_skills_interview_coaching_7'
		choose 'mentor_skills_job_search_5'
		choose 'mentor_skills_resume_development_8'
		choose 'mentor_skills_github_account_development_6'
		choose 'mentor_skills_selling_idea_4'
		choose 'mentor_mentee_gender_n'
		fill_in 'mentee_extra_info', :with => 'Other info'

		select "Ruby on Rails July/August", :from => "mentor_cf_class"
		click_button "Submit Profile"
		page.should have_content('Thank You!')
	end
end