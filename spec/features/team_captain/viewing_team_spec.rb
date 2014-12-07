# viewing_team_spec.rb
require 'spec_helper'
feature 'viewing team' do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:enemy_team) { FactoryGirl.create(:team) }
  let(:team_captain) { FactoryGirl.create(:team_captain, team: team) }
  before do
    sign_in_as!(team_captain)
    visit '/'
    click_link 'Team Captain'
  end
  scenario 'can view its own team' do
    expect(page).to have_content(team_captain.name)
    expect(page).to have_content(team_captain.hp)
  end
end