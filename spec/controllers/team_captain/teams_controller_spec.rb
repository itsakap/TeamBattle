# teams_controller_spec.rb
require 'spec_helper'
describe TeamCaptain::TeamsController, type: :controller do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:opponent_team) { FactoryGirl.create(:team) }
  let(:user) { FactoryGirl.create(:user) }
  let(:team_captain) { FactoryGirl.create(:team_captain, team: team)}
  def cannot_view_any_team_stats_page!
    get 'show', :id => team
    expect(response).to redirect_to('/')
    expect(flash[:alert]).to eql("You must be this team's team captain to continue.")
  end
  context 'anonymous user' do
    it 'cannot cannot_view_any_team_stats_page' do
      get 'show', :id => team
      expect(response).to redirect_to(sign_in_path)
      expect(flash[:error]).to eql("You need to sign in or sign up before continuing")
    end
  end
  context 'player (signed up, non-team captain)' do
    before { sign_in(user) }
    it 'cannot view any team stats page' do
      cannot_view_any_team_stats_page!
    end
  end
  context 'team captain' do
    before { sign_in(team_captain) }
    it 'cannot view opponent team stats page' do
      get 'show', :id => opponent_team
      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql("You must be this team's team captain to continue.")
    end
  end
end
