# joining_game_spec.rb
require 'spec_helper'
feature 'joining game' do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:team_captain) { FactoryGirl.create(:team_captain, team: team) }
  let!(:game) { FactoryGirl.create(:game) }

  before do
    sign_in_as!(team_captain)
    visit '/'
    click_link 'Join Game'
  end

  scenario 'can join game' do
    click_link game.name

    click_button "Join #{game.name}"
    expect(page).to have_content("Successfully joined #{game.name}")
  end

end