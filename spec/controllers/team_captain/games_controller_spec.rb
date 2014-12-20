# games_controller_spec.rb
require 'spec_helper'
describe TeamCaptain::GamesController, type: :controller do
  let!(:game) { FactoryGirl.create(:game) }
  let!(:team) { FactoryGirl.create(:team) }
  let(:team_captain) { FactoryGirl.create(:team_captain, team: team)}
  context 'team captain' do
    before { sign_in(team_captain) }
    it 'can create game for first time' do
      post :create, :game => {:name => 'Bring your A Game'}
      expect(flash[:notice]).to eql("Game was successfully created")
      expect(response).to redirect_to(root_path)
    end

    it 'can join game when not in a game' do
      patch :join_game, :id => game
      expect(response).to redirect_to(team_captain_game_path(game))
      expect(team_captain.reload.game).to eq(game)
    end
    it 'cannot create/join a game when already in a game' do
      post :create, :game => {:name => 'Bring your A Game'}
      team_captain.reload
      patch :join_game, :id => game
      expect(flash[:error]).to be
    end
  end
end