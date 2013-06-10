=begin
require 'spec_helper'

feature "a mentor ranks students they want to work with" do
  let!(:mentor){Factory(:mentor)}
  let!(:student){Factory(:student)}

  scenario "a mentor ranks students" do
    sign_in_as!(mentor)
    click_link student.personal_first_name + ' ' + student.personal_last_name
    click_link "Add to Ranking"
    content "Give " + student.personal_first_name + ' ' + student.personal_last_name +
            " a ranking"
    content "All following rankings will be bumped down the ranks."
    content "You have a maximum of 5 rankings"
    select "2", from: "rank"
    click_button "+ Ranking"
    content student.personal_first_name + ' ' + student.personal_last_name +
            ' has been adding to your rankings'
  end

  scenario "a mentor views their rankings" do
    sign_in_as!(mentor)
    click_link student.personal_first_name + ' ' + student.personal_last_name
    click_link "Add to Ranking"
    select "2", from: "rank"
    click_button "+ Ranking"
    click_link "Dashboard"
    click_link "View Rankings"
  end

end
=end