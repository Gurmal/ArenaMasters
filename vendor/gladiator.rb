require_relative 'Dice'

class Team
  def initialize(name)
    @name = name
    @accountbalance = 1000
    @reputation = 0
    @teamID = rand()
    @roster = Array.new(10)
    return @teamID
  end

  attr_reader   :name
  attr_accessor :roster
  attr_accessor :accountbalance

  def to_s
    @roster.each { |x| @reputation += x.reputation if !x.nil?}
    base = "Name: #@name Accout:#@accountbalance Rep:#@reputation\n"
    @roster.each { |x| base += " #{x}\n" if !x.nil?}
    return base
  end

  def hire(newhire)
    @accountbalance -= newhire.value
    x = 0
    while x < 10
      if @roster[x].nil?
        @roster[x] = newhire
        break
      end
      x+=1
  end
  puts "No Room for "+newhire.name.to_s if x == 10
  end

  def backfill(top=10)
    for i in 0...top
        self.hire(Gladiator.new("RedShirt"+i.to_s))
      end
  end
end

class Gladiator
  def initialize(name="Friday",fightStyle=0)
    @GID = rand()
    @name = name
    @fightStyle = fightStyle
    statdie = Dice.new(20)
    @available = true

    @str = statdie.roll
    @dex = statdie.roll
    @spd = statdie.roll
    @con = statdie.roll
    @chr = statdie.roll
    @intl = statdie.roll

    @value = @str + @dex + @spd + @con + @chr + @intl

    @HP = 10+@con
    @hitMod = 2 if @dex > 18
    @strMod = 2 if @str > 18

    @birth = Time.new
    @firstfight = '1/1/2001'
    @death = '1/1/2001'

    @wounds = 0
    @reputation = 0

    return @GID
  end

  attr_reader :GID
  attr_reader :name
  attr_reader   :str
  attr_reader   :dex
  attr_reader   :spd
  attr_reader   :con
  attr_reader   :chr
  attr_reader   :intl
  attr_reader   :initiative
  attr_reader   :hitMod
  attr_reader   :strMod
  attr_reader   :value

  attr_accessor :HP
  attr_accessor :wounds
  attr_accessor :reputation
  attr_accessor :availablez

  def setStyle(fightStyle)
    @fightStyle = fightStyle
  end
  def setName(name)
    @name = name
  end

  def to_s
    "Name:#@name Str:#@str Con:#@con HP:#@HP Dex:#@dex Wnd:#@wounds Rep:#@reputation Val:#@value Style:#@fightStyle Spd:#@spd"
  end

  def setHP
    @HP = 10 + @con - @wounds
  end

  def cleanup
    @wounds += 1 if @HP <= 0
    @value = @str + @dex + @spd + @con + @chr + @intl + @reputation
    @firstfight = 'today' if @firstfight == '1/1/2001'
  end

  def setInitiative
    iDie = Dice.new(20)
    @initiative = iDie.roll()
    @initiative += 2 if @spd >18
    #puts @name + " I:"+@initiative.to_s
  end
end


