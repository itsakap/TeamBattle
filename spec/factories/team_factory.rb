# team_factory.rb
FactoryGirl.define do
  sequence(:name) {|n| "team #{n}"}
  factory :team do
    name {generate(:name)}
  end
end