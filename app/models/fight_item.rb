class FightItem < ApplicationRecord
  belongs_to :fight
  belongs_to :gladiator
  
  def setupFight
	self.initiative = self.gladiator.initiative
	self.hp = self.gladiator.hp
	self.save
  end
  
  def name
	self.gladiator.name
  end
  def strmod
	self.gladiator.strmod
  end
  def hitmod
	self.gladiator.hitmod
  end
  
    def to_s
    "HP:#{self.hp} Initiative:#{self.initiative} name:#{self.gladiator.name}"
  end
  private
end
