class Team < ApplicationRecord
  has_many :gladiators
  has_many :events
  
  before_create :setvars

  private
  def setvars
      self.accountbalance = 1000
      self.reputation = 0
  end
end
