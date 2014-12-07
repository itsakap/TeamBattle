# users_controller_spec.rb
require 'spec_helper'
describe TeamCaptain::TeamsController, type: :controller do
  let!(:team) { FactoryGirl.create(:team) }
  let!(:opponent_team) { FactoryGirl.create(:team) }
  let(:user) { FactoryGirl.create(:user) }
  let(:team_captain) { FactoryGirl.create(:team_captain, team: team)}
  context 'standard user (signed up, non-team captain)' do
    before { sign_in(user) }
    it 'cannot view any team stats page' do
      get 'show', :id => team
      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql("You must be this team's team captain to do that.")
    end
  end
  context 'team captain' do
    before { sign_in(team_captain) }
    it 'cannot view opponent team stats page' do
      get 'show', :id => opponent_team
      expect(response).to redirect_to('/')
      expect(flash[:alert]).to eql("You must be this team's team captain to do that.")
    end
  end
end
