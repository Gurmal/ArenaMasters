class FightState
  
  attr_accessor  :position,
                 :heading,
                 :hp,
                 :debuff,
                 :buff,
                 :atk,
                 :dmg

  def initialize()
    #where the fighter is and their orientation and moment of motion
    @position = {'x' => 0, 'y' => 0, 'z' => 0}
    @heading = {'x' => 0, 'y' => 0, 'z' => 0, 'spin' => 0, 'inertia' => 0}
  
    #fighters health at this point
    @hp = 0
    @debuff = nil
    @buff = nil

    #fighter's attack results
    @atk = 0
    @dmg = 0
  end

  #where is the fighter located in the arena - d not used
  def setPosition(x,y,z,d=0)
    @position['x'] = x
    @position['y'] = y
    @position['z'] = z
  end

#which direction is the fighter pointing, spin and inertia are optional
  def setHeading(x,y,z,spin=0, inertia = 0)
    @heading['x'] = x
    @heading['y'] = y
    @heading['z'] = z
    @heading['spin'] = spin
    @heading['inertia'] = inertia
  end

  def moveTo(x,y,z,try=true,turn=true)
    #if try is true do it, calculate the cost without executing the move
    #move the fighter from the current coordinates to the provided coordinates
    #Set the delta correctly
    #if turn is true set the heading correctly
    #return the cost
  end

#used to duplicate a fightstate item
def dup
  fs = FightState.new
  fs.setPosition(@position['x'],@position['y'],@position['z'],@position['d'])
  fs.setHeading(@heading['x'],@heading['y'],@heading['z'],@heading['d'])
  fs.hp = @hp
  fs.debuff = @debuff
  fs.buff = @buff
  fs.atk = @atk
  fs.dmg = @dmg
  return fs
end

  def to_s
    @position['x'].to_s+','+@position['y'].to_s+','+@position['z'].to_s+','+@position['d'].to_s
  end

  def to_i
    #@lastroll
  end

  #def coerce(other)
    #[self.class.new(@to_i),self]
  #end

  #def <=>(other)
   # to_i <=> @to_i
  #end

  #def +(other)
    #to_i + @to_i
  #end
end

#some light testing
  @rs = Array.new
  as = Array.new
  as << FightState.new
  as.last.setPosition(1,1,0)
  as.last.hp = 1
  @rs << as
  