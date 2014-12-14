require 'spec_helper'

describe Move, type: :model do
  let!(:started_game) { FactoryGirl.create(:started_game) }
  let!(:team_a) { FactoryGirl.create(:team, game: started_game) }
  let!(:team_b) { FactoryGirl.create(:team, game: started_game) }
  let!(:user_a) { FactoryGirl.create(:user, team: team_a, game: started_game) }
  let!(:user_b) { FactoryGirl.create(:user, team: team_a, game: started_game)}
  let!(:user_c) { FactoryGirl.create(:user, team: team_b, game: started_game) }


  it "When move choice is 'Attack' target must be on opponent team" do

    user_a.move.move_choice = 'Attack'
    user_a.move.target = user_b.id

    user_a.move.save
    expect(user_a.move).to_not be_valid

    user_a.move.target = user_c.id
    user_a.move.save
    expect(user_a.move).to be_valid
  end

  it "When move choice is 'Heal' target must be on same team" do

    user_a.move.move_choice = 'Heal'
    user_a.move.target = user_c.id

    user_a.move.save
    expect(user_a.move).to_not be_valid

    user_a.move.target = user_b.id
    user_a.move.save
    expect(user_a.move).to be_valid
  end

  it "When move choice is 'Defend' or 'Surrender' target must be nil" do
    ["Defend", "Surrender"].each do |move_that_requires_no_target|
      user_a.move.move_choice = move_that_requires_no_target
      user_a.move.target = user_c.id

      user_a.move.save
      expect(user_a.move).to_not be_valid

      user_a.move.target = nil
      user_a.move.save
      expect(user_a.move).to be_valid
    end
  end
end
