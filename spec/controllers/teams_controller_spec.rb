# teams_controller_spec.rb
require 'spec_helper'
describe TeamsController, type: :controller do
  let!(:user) { FactoryGirl.create(:user) }
  before do
    sign_in(user)
  end
  it 'promotes user to captain upon creation of team' do
    post :create, :team => {:name => 'aaa'}
    expect(User.find(user.id).captain?).to be(true)
  end
end