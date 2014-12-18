class Team < ActiveRecord::Base
  has_many :users
  belongs_to :game
  scope :available, ->{ where(:started? => false) }
  scope :alive, ->{ where(:eliminated? => false) }
end
