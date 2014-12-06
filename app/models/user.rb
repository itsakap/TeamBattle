class User < ActiveRecord::Base
  include ActiveModel::Validations
  validates_presence_of :email
  validates_presence_of :name
  validate :stats_sum_does_not_exceed_ten
  validates :x, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :z, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  has_secure_password

  def stats_sum_does_not_exceed_ten
    if (x+y+z) > 10
      errors.add(:x, "cannot sum with y and z to exceed 10")
    end
  end

  def hp
    200 + (10*x)
  end

  def attack_power
    20 + y
  end

  def heal_power
    20 + z
  end

end
