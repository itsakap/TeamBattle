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
    expect(page).to have_content("Team Name")

    fill_in 'Team Name', with: 'Sentinels'
    click_button "Create Team"
    expect(page).to have_content("Team created successfully.")
    expect(user.reload.captain?).to be(true)
  end
end