require 'spec_helper'

feature "a mentor ranks students they want to work with" do
  let!(:user){Factory(:confirmed_user)}
  let!(:mentor){Factory(:mentor, user: user)}
  let!(:student){Factory(:student)}

  scenario "a mentor ranks students" do
    sign_in_as!(mentor.user)
    click_link student.personal_first_name + ' ' + student.personal_last_name
    click_link "Add to Ranking"
    content student.personal_first_name + ' ' + student.personal_last_name +
            ' has been added to your rankings.'
  end

  scenario "a mentor views their rankings" do
    sign_in_as!(mentor.user)
    click_link student.personal_first_name + ' ' + student.personal_last_name
    click_link "Add to Ranking"
    click_link "Dashboard"
    click_link "View Your Rankings"
  end

end