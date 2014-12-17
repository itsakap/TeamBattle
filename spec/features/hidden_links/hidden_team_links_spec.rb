# hidden_team_links_spec.rb
require 'spec_helper'
feature 'hiding team building links' do
  let(:user) { FactoryGirl.create(:user) }
  let!(:team) { FactoryGirl.create(:team) }
  let!(:team_captain) { FactoryGirl.create(:team_captain, team: team) }

  context 'anonymous (not signed in) users' do
    scenario 'cannot see Team Building links' do
      visit '/'
      assert_no_link_for 'Create team'
      assert_no_link_for 'View & Join a Team'
    end

  end

  context 'non team-captain players' do
    before { sign_in_as!(user) }
    scenario 'can see Team Building links only if not on a team' do
      visit '/'
      assert_link_for 'Create team'
      click_link 'View & Join a Team'
      click_link team.name
      click_button "Join team"
      assert_no_link_for 'Create team'
      click_link 'View & Join a Team'
      click_link team.name
      assert_no_button_for "Join team"
    end
  end

  context 'team captain players' do
    before { sign_in_as!(team_captain) }
    scenario 'cannot see Team Building links (already on a team!)' do
      visit '/'
      assert_no_link_for 'Create team'
      click_link 'View & Join a Team'
      click_link team.name
      assert_no_button_for "Join team"
    end
  end

end