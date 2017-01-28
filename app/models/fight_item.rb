require 'FightState'
class FightItem < ApplicationRecord
  belongs_to :fight
  belongs_to :gladiator
  attr_accessor  :rState
  
  def setupFight
    _log=""
    #initialize the Fight Item with the gladiator's information
    self.initiative = self.gladiator.rollInitiative
  	self.hp = self.gladiator.hp
    self.won = false
    self.died = false
    self.wounded = false
  	self.save
    _log = self.gladiator.name+' fights with a '+self.gladiator.getStyleName+' style.<br>'
    
    #memory only variables for life of fight - not being stored to the database
    #initialize the round array with the first action array which contains a fight state that is the starting condition of the fighter
    #use the zero position for initialization - hence round 1 will be stored in array 1
    @rState = Array.new  #RoundState
    as = Array.new #ActionState
    as << FightState.new
    as.last.setPosition(0,0,0)
    as.last.hp = self.hp
    @rState << as

    return _log

  end

  def startRound
    #add another action array to the round state array with a copy of the last fightstate as the first element of the action array
    as = Array.new #ActionState
    as << @rState.last.last.dup #duplicate the last action of the last round as the zero state of the new action array
    @rState << as #add the action array as a new element of the round array
    return @rState.last.last #return the most recent fightstate
  end

  def addAction(atk,dmg)
    #add another action to the acction array with a copy of the last fightstate as the first element of the action array
    action = @rState.last.last.dup #duplicate the last action of the last round as the starting new action item
    action.atk = atk
    action.dmg = dmg
    @rState.last << action #push it onto the state array
    return @rState.last.last #return the most recent fightstate (this action)
  end

  def cleanupFight
    _log = ""
    self.gladiator.setFirstFight if self.gladiator.firstfight.nil? #consider moving this to cleanup - allowing no for no gladiator changes until end of fight
    if self.hp < 0
      self.gladiator.killMe
      self.died = :true
      _log = '<font color="red">'+self.gladiator.name+' has died from his wounds.</font><br>'
    elsif self.hp < 2
      self.wounded = :true
      self.gladiator.addWound
      _log = '<font color="red">'+self.gladiator.name+' has been geviously wounded and is carried from the arena.</font><br>'
    end
    self.save
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
