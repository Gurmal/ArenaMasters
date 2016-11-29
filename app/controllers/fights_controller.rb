class FightsController < ApplicationController
  before_action :set_fight

  def show
  end

  def run
    $loglevel = 4
    @log=""
    @fighters.each { |x| x.setHP
    x.setInitiative}


    #initiative - identify fighter 1
 	@fighters.sort	{ |x,y| x.initiative <=> y.initiative}

    @log << @fighters[0].name+" goes first with initiative:"+@fighters[0].initiative.to_s+" vs "+@fighters[1].initiative.to_s if $loglevel >= 2

    #fight
    @fightRound = 0

    while (@fighters[0].hp > 2) && (@fighters[1].hp > 2) && (@fighters[0].hp != @fighters[1].hp)
      @fightRound+=1
      @log << "Round "+@fightRound.to_s if $loglevel >= 2
      attack(@fighters[0],@fighters[1])
      attack(@fighters[1], @fighters[0])
      @log << @fighters[0].hp.to_s+":"+@fighters[1].hp.to_s if $loglevel >= 3
    end

    #declare winner
    if @fighters[0].hp > @fighters[1].hp
      @fight.winner = @fighters[0].name
      @fighters[0].reputation += 1
      @fighters[1].reputation -= 1
    else
      @fight.winner = @fighters[1].name
      @fighters[1].reputation += 1
      @fighters[0].reputation -= 1
    end
    
    #dole out wounds
    @fighters.each { |x| x.cleanup
    @log << x.name+" has died from his wounds." if x.hp <= 0 } if $loglevel >= 1
    
    logger.info(@log)
    @fight.save

    redirect_to event_fight_path(@event,@fight), notice: @log
  end


  private
  #used by controller to set class vars
  def set_fight
  	@fight = Fight.find(params[:id])
  	@fighters = @fight.gladiators
  	@event = @fight.event
  end

	#used by run
    def attack(attacker,defender)
    hitDie = Dice.new
    atkDie = Dice.new(4)
    damage = (atkDie + attacker.strmod)
    @log << "dHP:"+defender.hp.to_s if $loglevel >= 3
    #attackers 1d20 + dexterity modifier against defenders spd
    if (hitDie + attacker.hitmod) < 4
      @log<< attacker.name+" misses." if $loglevel >= 2
    elsif (hitDie + attacker.hitmod) > 18
      defender.hp -= (2*damage)
      @log << attacker.name+" criticaly hits for "+ (2*damage).to_s + " damage." if $loglevel >= 2
    else
      defender.hp -= damage
      @log << attacker.name+" hits for "+ damage.to_s + " damage." if $loglevel >=2
    end
  end
end
