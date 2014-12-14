# game_factory.rb
FactoryGirl.define do
  sequence(:game_name) {|n| "game #{n}" }
  factory :game do
    name { generate(:game_name) }
    factory :started_game do
      started? true
    end
  end
end

