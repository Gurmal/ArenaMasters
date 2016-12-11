class FightsController < ApplicationController
  before_action :set_fight

  def show
  end

  def run
    $loglevel = 4
    @log=""
    @fighters = @fight.fight_items
     @log << @fighters.class.to_s+'<br>' if $loglevel >= 5
	@fighters.each { |x| x.setupFight}


    #initiative - identify fighter 1
 	@fighters.sort	{ |x,y| y.initiative <=> x.initiative}

    @log << @fighters[0].name+' goes first with initiative '+@fighters[0].initiative.to_s+' vs '+@fighters[1].name+' with '+@fighters[1].initiative.to_s+'<br>' if $loglevel >= 2

    #fight
    @fightRound = 0

    while (@fighters[0].hp > 2) && (@fighters[1].hp > 2) && (@fighters[0].hp != @fighters[1].hp)
      @fightRound+=1
      @log << '<b>Round: '+@fightRound.to_s+'</b><br>' if $loglevel >= 2
      attack(@fighters[0],@fighters[1])
      attack(@fighters[1], @fighters[0])
      @log << @fighters[0].name+'('+@fighters[0].hp.to_s+') '+@fighters[1].name+'('+@fighters[1].hp.to_s+')<br>' if $loglevel >= 3
    end

    #declare winner
    maxFighter = @fighters.max_by {|x| x.hp}
    @log << '<font color="green">'+maxFighter.name+' has won the match.</font><br>' if $loglevel >= 1

    if @fighters[0].hp > @fighters[1].hp
      @fight.winner = @fighters[0].name
      @fighters[0].gladiator.reputation += 1
      @fighters[1].gladiator.reputation -= 1
    else
      @fight.winner = @fighters[1].name
      @fighters[1].gladiator.reputation += 1
      @fighters[0].gladiator.reputation -= 1
    end
    
    #dole out wounds
    @fighters.each { |x| x.gladiator.cleanup
    @log << '<font color="red">'+x.name+' has died from his wounds.</font><br>' if x.hp <= 0 } if $loglevel >= 1
    
    logger.info(@log)
	@fight.log = @log
    @fight.save

    redirect_to event_fight_path(@event,@fight), notice: 'Fight Complete!'
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
    @log << 'aHP:'+attacker.hp.to_s+'; dHP:'+defender.hp.to_s+'<br>' if $loglevel >= 4
    #attackers 1d20 + dexterity modifier against defenders spd
      if (hitDie + attacker.gladiator.hitmod) < 4
        @log<< attacker.name+' misses '+defender.name+'.<br>' if $loglevel >= 2
      elsif (hitDie + attacker.gladiator.hitmod) > 18
        damage = (4 + attacker.gladiator.strmod)
        defender.hp -= damage
        @log << attacker.name+' criticaly hits '+defender.name+' for '+damage.to_s+' damage.<br>' if $loglevel >= 2
      else
        damage = (atkDie + attacker.gladiator.strmod)
        defender.hp -= damage
        @log << attacker.name+' hits '+defender.name+' for '+damage.to_s+' damage.<br>' if $loglevel >= 2
      end
      @log << 'aHP:'+attacker.hp.to_s+'; dHP:'+defender.hp.to_s+'<br>' if $loglevel >= 4
  end
end
