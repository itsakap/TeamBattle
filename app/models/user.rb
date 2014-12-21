class User < ActiveRecord::Base
  include ActiveModel::Validations
  # RELATIONS
  belongs_to :team
  belongs_to :game
  has_one :move, dependent: :delete  # destroys the associated move
  # VALIDATIONS
  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :x
  validates_presence_of :y
  validates_presence_of :z
  validate :stats_sum_does_not_exceed_max
  validates :x, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :z, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  #AUTHENTICATION
  has_secure_password
  #TRIGGERS
  before_create :set_stats
  #SCOPES
  scope :alive, ->{ where(:eliminated? => false) }

  def self.stats_sum_maximum
    10
  end

  def stats_sum_does_not_exceed_max
    if (x+y+z) > User.stats_sum_maximum
      errors.add(:x, "cannot sum with y and z to exceed 10")
    end
  end
  
  def starting_hp
    100 + (10*x)
  end

  def attack_power
    20+y
  end
  def heal_power
    20+z
  end

  def set_stats
    self.hp = starting_hp
    self.build_move
  end 




end
