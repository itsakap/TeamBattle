# editing_team_spec.rb
require 'spec_helper'
feature 'editing team' do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:team_captain) { FactoryGirl.create(:team_captain, team: team) }
  let!(:user) { FactoryGirl.create(:user, team: team) }
  before do
    sign_in_as!(team_captain)
    visit '/'
    click_link 'Team Captain'
  end

  scenario 'editing team name' do

    fill_in "Team Name", with: "Weekend Warriors"
    click_button "Update Team"

    expect(page).to have_content("Weekend Warriors")
  end

  scenario 'removing team members' do

    expect(page).to have_content(user.name)
    click_button "Remove #{user.name} from team"

    expect(page).to have_content("Removed #{user.name} from team")
    
    within '#teammates' do
      expect(page).to_not have_content(user.name)
    end
  end

end