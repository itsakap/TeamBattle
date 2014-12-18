require 'spec_helper'

describe Move, type: :model do
  let!(:started_game) { FactoryGirl.create(:started_game) }
  let!(:other_started_game) { FactoryGirl.create(:started_game) }
  let!(:team_a) { FactoryGirl.create(:team, game: started_game) }
  let!(:team_b) { FactoryGirl.create(:team, game: started_game) }
  let!(:team_c) { FactoryGirl.create(:team, game: other_started_game) }
  let!(:user_a) { FactoryGirl.create(:user, team: team_a, game: started_game) }
  let!(:user_b) { FactoryGirl.create(:user, team: team_a, game: started_game)}
  let!(:user_c) { FactoryGirl.create(:user, team: team_b, game: started_game) }
  let!(:user_d) { FactoryGirl.create(:user, team: team_c, game: other_started_game) }
  context "Move choice is 'Attack'" do
    before { user_a.move.move_choice = 'Attack' }
    it "User should be able to attack target on game's opponent team" do
      user_a.move.target = user_c.id
      expect(user_a.move).to be_valid
    end
    it "User should not be able to attack target on his/her team" do
      user_a.move.target = user_b.id
      expect(user_a.move).to_not be_valid
    end
    it "User should not be able to attack user in another game" do
      user_a.move.target = user_d.id
      expect(user_a.move).to_not be_valid
    end
  end

  context "Move choice is 'Heal'" do
    before { user_a.move.move_choice = 'Heal' }
    it 'User should not be able to heal target on another team' do
      user_a.move.target = user_c.id
      expect(user_a.move).to_not be_valid
    end
    it 'User should be able to heal target on same team' do
      user_a.move.target = user_b.id
      expect(user_a.move).to be_valid
    end
  end

  ["Defend", "Surrender"].each do |move_that_requires_no_target|
    it "When move choice is #{move_that_requires_no_target} target must be nil" do
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
