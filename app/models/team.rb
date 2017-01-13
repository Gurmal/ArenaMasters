class Team < ApplicationRecord
  has_many :gladiators
  has_many :events
  
  before_create :setvars
  
  #used to populate a team back up to 10 gladiators
  def backfill
    i = 0
    #count only the live gladiators
    _liveTeam = self.gladiators.select{|x| x.death.nil?}
    while i < (10 - _liveTeam.count)
      nameslist = ['Abner','Bob', 'Cindy', 'Dwane', 'Eli' , 'Frank', 'Gwen', 'Hodor', 'Ileen','Jane', 'Kas']
        self.gladiators.build(name: nameslist.sample+rand(999).to_s)
        i+=1
    end
    self.save
  end

  private
  def setvars
      self.accountbalance = 1000
      self.reputation = 0
      self.active = :true
  end
end
