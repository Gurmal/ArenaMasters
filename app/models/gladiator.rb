require_relative 'Dice'
$loglevel = 1

class Gladiator < ApplicationRecord
  belongs_to :team
  has_many :fight_items
  has_many :fights, through: :fight_items
  
  before_create :setstats




  def setStyle(fightStyle)
    self.fightStyle = fightStyle
    self.save
  end

  def setName(name)
    self.name = name
    self.save
  end

  def to_s
    "Name:#{self.name} Str:#{self.str} Con:#{self.con} HP:#{self.HP} Dex:#{self.dex} Wnd:#{self.wounds} Rep:#{self.reputation} Val:#{self.value} Style:#{self.fightStyle} Spd:#{self.spd}"
  end

  def setHP
    self.hp = (10 + self.con) - self.wounds
    self.save
  end

  def cleanup
    self.wounds += 1 if self.hp <= 0
    #self.value = self.str + self.dex + self.spd + self.con + self.chr + self.intl + self.reputation
    self.firstfight = 'today' if self.firstfight == '1/1/2001'
    self.save
  end

  def setInitiative
    iDie = Dice.new(20)
    self.initiative = iDie.roll
    self.initiative += 2 if self.spd.to_i >18
    self.save
    #puts @name + " I:"+@initiative.to_s
  end


private
  def setstats
    statdie = Dice.new(20)
    _str = statdie.roll
    self.str = _str
    _dex = statdie.roll
    self.dex = _dex

    self.spd = statdie.roll
    _con = statdie.roll
    self.con = _con
    self.chr = statdie.roll
    self.intl = statdie.roll

    # @value = @str + @dex + @spd + @con + @chr + @intl

    self.hp = 10+_con
    if _dex > 18 
      self.hitmod = 2 
    else 
      self.hitmod = 0
    end
    if _str > 18
      self.strmod = 2
    else
      self.strmod = 0 
      end

    self.birth = Time.new
    #self.firstfight = '1/1/2001'
    #self.death = '1/1/2001'

    self.fightStyle = 0
    self.wounds = 0
    self.reputation = 0
  end
end