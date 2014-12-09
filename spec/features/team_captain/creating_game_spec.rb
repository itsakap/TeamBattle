# creating_game_spec.rb
require 'spec_helper'
feature 'creating game' do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:team_captain) { FactoryGirl.create(:team_captain, team: team) }

  before do
    sign_in_as!(team_captain)
    visit '/'
    click_link 'New Game'
  end

  scenario 'can create a game' do

    fill_in 'Game Name', with: "3v3"
    click_button 'Create Game'

    expect(page).to have_content('Game was successfully created')
  end

  scenario 'game with invalid attributes is not created' do
    click_button 'Create Game'
    expect(page).to have_content('Game was not created')
  end
end