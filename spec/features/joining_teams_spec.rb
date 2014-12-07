# joining_teams_spec.rb
require 'spec_helper'
feature 'joining a team' do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:enemy_team) { FactoryGirl.create(:team) }
  let!(:team_captain) { FactoryGirl.create(:team_captain, team: team) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(user)
    visit '/'
  end

  scenario 'can join only one team' do
    click_link 'Join a team'
    click_link team.name
    expect(page).to have_content( "#{team_captain.name} - #{team_captain.email} (captain)" )
  
    click_button 'Join team'
    expect(page).to have_content("Successfully joined team. You are now a member of this team: #{team.name}")

    within("#teammates") { expect(page).to have_content(user.name) }
    
    click_button 'Join team'
    expect(page).to have_content("You are already on this team: #{Team.find(user.reload.team_id).name}")
  end

end
