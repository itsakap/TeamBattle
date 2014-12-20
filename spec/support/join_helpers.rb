# join_helpers.rb
module JoinHelpers
  def join_team!(team)
    click_link 'Join a Team'
    click_link team.name
    click_button "Join team"
    expect(page).to have_content("Successfully joined team. You are now a member of this team: #{team.name}")
  end
  def create_game!
    click_link 'New Game'
    fill_in "Name", with: "Experts Only"
    click_button "Create Game"
  end
  def join_game!
    click_link 'Join Game'
    click_link "Experts Only"
    click_button "Join Experts Only"
  end

end
RSpec.configure do |c|
  c.include JoinHelpers, :type => :feature
end