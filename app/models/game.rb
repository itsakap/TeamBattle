class Game < ActiveRecord::Base
  validates_presence_of :name
  has_many :teams
  has_many :users
  # scope for available games (available to join)
  scope :available, ->{ where(:started? => false) }
  scope :in_progress, ->{ where(:started? => true) }
end
