# viewing_teams_spec.rb
require 'spec_helper'
feature "Viewing Team" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:team) { FactoryGirl.create(:team) }
  before do
    sign_in_as!(user)
    visit '/'
  end
  scenario "Viewing all teams" do
    click_link 'View & Join a Team'
    expect(page).to have_content(team.name)
  end
end
