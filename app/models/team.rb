class Team < ActiveRecord::Base
  has_many :users
  belongs_to :game
  # scope for teams that haven't started their games (available to join)
end
