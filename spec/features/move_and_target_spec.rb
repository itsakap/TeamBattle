# move_and_target_spec.rb
require 'spec_helper'
feature 'choose move and target opponent player', :js => true do
  # we need to mock a lot of things to test this:
  # a game, two teams in the game, and a user on each team
  let!(:started_game) { FactoryGirl.create(:started_game) }
  let!(:team_a) { FactoryGirl.create(:team, game: started_game) }
  let!(:team_b) { FactoryGirl.create(:team, game: started_game) }
  let!(:user_a) { FactoryGirl.create(:user, team: team_a, game: started_game) }
  let!(:user_b) { FactoryGirl.create(:user, team: team_a, game: started_game) }
  let!(:user_c) { FactoryGirl.create(:user, team: team_b, game: started_game) }

  before do
    sign_in_as!(user_a)
    visit '/'
    click_link 'My Game'
  end

  scenario 'game has begun, and user a decides to attack user c on the first night' do
    select('Attack', :from => "move[move_choice]")
    select(user_c.name, :from => "move[target]")
    click_button "Update Move"
    expect(page).to have_content("Move was updated.")
    # expect user_b.hp to decrease by user_a.attack_power (unless user_b is defending)
  end

  scenario 'user a changes his mind, and decides to heal teammate user b' do
    select('Heal', :from => "move[move_choice]")
    select(user_b.name, :from => "move[target]")
    click_button "Update Move"
    expect(page).to have_content("Move was updated")
  end
end
