# user_factory.rb
FactoryGirl.define do
  sequence(:email) {|n| "user#{n}@aol.jp"}
  factory :user do
    name "Adam"
    email {generate(:email)}
    password 'password'
    password_confirmation 'password'
    x 1
    y 3
    z 5
  end
end