# team_factory.rb
FactoryGirl.define do
  sequence(:team_name) {|n| "team #{n}"}
  factory :team do
    name { generate(:team_name) }
  end
end