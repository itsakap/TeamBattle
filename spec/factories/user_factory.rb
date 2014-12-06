# user_factory.rb
FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@aol.jp"}
  sequence(:user) {|n| "xxuser#{n}xx"}
  factory :user do
    name {generate(:user)}
    email {generate(:email)}
    password 'password'
    password_confirmation 'password'
    x 1
    y 3
    z 5
    factory :team_captain do
      captain? true
    end
  end
end