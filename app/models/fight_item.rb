class FightItem < ApplicationRecord
  belongs_to :fight
  belongs_to :gladiator
  
  def setupFight
	self.gladiator.setFirstFight if self.gladiator.firstfight.nil?
  self.initiative = self.gladiator.rollInitiative
	self.hp = self.gladiator.hp
	self.save
  end

  def cleanupFight
    _log = ""
    if self.hp < 0
      self.gladiator.killMe if self.hp < 0
      _log = '<font color="red">'+self.gladiator.name+' has died from his wounds.</font><br>'
    elsif self.hp < 2
      self.gladiator.addWound
      _log = '<font color="red">'+self.gladiator.name+' has been geviously wounded and is carried from the arena.</font><br>'
    end
    return _log
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
  
  def getInitiative
    self.initiative
  end

  def to_s
    "HP:#{self.hp} Initiative:#{self.initiative} name:#{self.gladiator.name}"
  end
  private
end
