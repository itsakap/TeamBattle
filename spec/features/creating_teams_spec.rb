# creating_teams_spec.rb
require 'spec_helper'
feature 'creating teams' do
  let!(:user){ FactoryGirl.create(:user) }
  before do
    visit '/'
    click_link "Sign in"
    fill_in "Username", with: user.name
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
  scenario 'creating a team' do
    click_link 'Create team'
    fill_in 'Team Name', with: 'Sentinels'
    click_button "Create team"
    expect(page).to have_content("Team created successfully.")
  end
end