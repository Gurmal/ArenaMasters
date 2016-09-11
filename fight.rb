require_relative 'Dice'

class Fight
  def initialize(gladiator1, gladiator2)
    @fighter = [gladiator1, gladiator2]
    @fightWinner = -1
    @fightID = rand()
    @fightRound = 0
    @fightLog = nil

  end

  attr_reader :fightWinner
  attr_reader :fighter

  def to_s
    @winner = @fightWinner.name
    "#@winner won fight in #@fightRound rounds."
  end

  def headline
    @fighter[0].name+" vs. "+@fighter[1].name
  end
  def run
    @fighter.each { |x| x.setHP
    x.setInitiative}


    #initiative
      #identify fighter 1
    if fighter[0].initiative < fighter[1].initiative
      fighter[0],fighter[1] = fighter[1], fighter[0]
    end
    puts @fighter[0].name+" goes first with initiative:"+@fighter[0].initiative.to_s+" vs "+fighter[1].initiative.to_s

    #fight
    @fightRound = 0

    while @fighter[0].HP > 2 && @fighter[1].HP > 2
      #@fighter[1].HP -= rand(2) #f1 attacks
      #@fighter[0].HP -= rand(2) #f2 attacks
      @fightRound+=1
      puts "Round "+@fightRound.to_s
      attack(fighter[0],fighter[1])
      attack(fighter[1], fighter[0])
      #puts fighter[0].HP.to_s+":"+fighter[1].HP.to_s

    end

    #declare winner
    if @fighter[0].HP > @fighter[1].HP
      @fightWinner = @fighter[0]
      fighter[0].reputation += 1
      fighter[1].reputation -= 1
    else
      @fightWinner = @fighter[1]
      fighter[1].reputation += 1
      fighter[0].reputation -= 1
    end
    puts self
    #dole out wounds
    @fighter.each { |x| x.cleanup
    puts x.name+" has died from his wounds." if x.HP <= 0 }
  end

  def attack(attacker,defender)
    hitDie = Dice.new
    atkDie = Dice.new(4)
    damage = (atkDie + attacker.strMod)
    #puts "dHP:"+defender.HP.to_s
    #attackers 1d20 + dexterity modifier against defenders spd
    if (hitDie + attacker.hitMod) < 4
      puts attacker.name+" misses."
    elsif (hitDie + attacker.hitMod) > 18
      defender.HP -= (2*damage)
      puts attacker.name+" criticaly hits for "+ (2*damage).to_s + " damage."
    else
      defender.HP -= damage
      puts attacker.name+" hits for "+ damage.to_s + " damage."
    end
  end
end

class Event
  def initialize(name, scheduledDate,*team)
    @fightNightID = rand()
    @name = name
    @scheduledDate = scheduledDate
    @runDate = Time.new
    @fightSchedule = [Fight.new(team[0].roster[0],team[1].roster[0]),Fight.new(team[0].roster[1],team[1].roster[1])]
    @team = team
    @FightNum = 1
  end

  def buildSchedule
#for each team 1, roster 1 find opponent on team 2
    @team.each { |x|
      x.roster.each { |y| @fightSchedule << Fight.new(y,} }

  end

  def run()
    @fightSchedule.each { |x| puts "\n***Fight "+@FightNum.to_s+"*** " +x.headline
    @FightNum+=1
    x.run }
  end
end

class Bet
  def initialize()
#do some money
  end
end