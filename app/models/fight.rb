class Fight < ApplicationRecord
	belongs_to :event
	has_many :fight_items, dependent: :destroy
	has_many :gladiators, through: :fight_items

def run
	#This runs the fight allowing the fighters to attack each other until there is a winner.
    $loglevel = 2
    @fight = self
    @log=""
    @fighters = @fight.fight_items
    if @fighters.count < 2
    		#ISSUE - this shouldn't happen but right now the scheduler will leave a single fighter in a fight.  If it does happen handle it gracefully.
    		@log << 'Only one fighter, ending fight'
    		@fight.winner = @fighters[0].name
    		@fighters[0].gladiator.reputation += 1
    else
		@fighters.each { |x| x.setupFight}

	    #initiative - identify fighter 1 sorting by their initiative rolls
	 	@fighters = @fighters.sort	{ |x,y| y.initiative <=> x.initiative}

	 	logger.info @fighters.inspect
	    @log << @fighters[0].name+' goes first with initiative '+@fighters[0].initiative.to_s+' vs '+@fighters[1].name+' with '+@fighters[1].initiative.to_s+'<br>' if $loglevel >= 2

	    #fight
	    @fightRound = 0

	    #Main action loop
	    #continues if everyone is above 2 or HP not equal (so we don't tie and can have a winner)
	    while @fighters.all? {|x| x.hp >=2 } || @fighters.all? {|x| x.hp == @fighters[0].hp}
	      @fightRound+=1
	      @fighters.each { |x| x.startRound} #set the initial Round State for each fighter based on prior round


	      @log << '<b>Round: '+@fightRound.to_s+'</b><br>' if $loglevel >= 2
	      @fighters.each { |x| @log << x.name+':'+x.rState.last.last.atk.to_s+':'+x.rState.last.last.dmg.to_s+'<br>'} if $loglevel >= 3
	      attack(@fighters[0],@fighters[1]) if @fighters[0].hp > 0
	      attack(@fighters[1], @fighters[0]) if @fighters[1].hp > 0
	      @log << @fighters[0].name+'('+@fighters[0].hp.to_s+') '+@fighters[1].name+'('+@fighters[1].hp.to_s+')<br>' if $loglevel >= 3
	    end

	    #declare winner  (this needs to switch over to using the won boolean on fight items)
	    maxFighter = @fighters.max_by {|x| x.hp}
	    @log << '<font color="green">'+maxFighter.name+' has won the match.</font><br>' if $loglevel >= 1

			#needs change to sort array, declair first winner rest loosers
			@fighters = @fighters.sort	{ |x,y| y.hp <=> x.hp}
		    cleanWinner(@fighters[0],@fighters[1])
		    @fighters.each{|x| x.save}
	    #dole out wounds
	    @fighters.each { |x| @log << x.cleanupFight }
   	end
	@fight.rounds = @fightRound

	#pushes the fight log to the server console
	logger.info(@log)
	#save the log
	@fight.log = @log
	@fight.complete = :true

	@fight.save
  end

  private
  #attack used by run
  def attack(attacker,defender)
    hitDie = Dice.new
    atkDie = Dice.new(4)
    _hitVerb = ['hits', 'smacks','cuts', 'knocks', 'slices', 'gouges']
    _critHitVerb = ['blasts', 'bludgeons', 'guts', 'dismembers', 'impales']
    _bodypart = ['arm', 'leg', 'shoulder', 'side', 'back', 'hand', 'foot', 'face', 'thigh', 'knee', 'ear']
    @log << 'aHP:'+attacker.hp.to_s+'; dHP:'+defender.hp.to_s+'<br>' if $loglevel >= 4
    #attackers 1d20 + dexterity modifier against defenders spd
      if (hitDie + attacker.gladiator.hitmod) < 4 #Miss
        @log<< attacker.name+' misses '+defender.name+'.<br>' if $loglevel >= 2
        attacker.addAction(0,0)
      elsif (hitDie + attacker.gladiator.hitmod) > 18 #Crit
        damage = (4 + attacker.gladiator.strmod)
        defender.hp -= damage
        attacker.addAction(2,damage)
        @log << attacker.name+' <i>criticaly</i> '+_critHitVerb.sample+' '+defender.name+' for '+damage.to_s+' damage.<br>' if $loglevel >= 2
      else #normal
        damage = (atkDie + attacker.gladiator.strmod)
        defender.hp -= damage
        attacker.addAction(1,damage)
        @log << attacker.name+' '+_hitVerb.sample+' '+defender.name+' in the '+_bodypart.sample+' for '+damage.to_s+' damage.<br>' if $loglevel >= 2
      end
      @log << 'aHP:'+attacker.hp.to_s+'; dHP:'+defender.hp.to_s+'<br>' if $loglevel >= 4
  end



 

  def cleanWinner(aWinner,aLoser)
	#issue 12 needs reputation fixes
	#14 reputation doesn't go up but it certainly goes down?!?
      @fight.winner = aWinner.name
      aWinner.won = true
      aWinner.gladiator.reputation += 1
      aWinner.gladiator.exp += 1
      aWinner.gladiator.save
      aLoser.gladiator.reputation -= 1
      aLoser.gladiator.exp += 1
      aLoser.gladiator.save
  end
end
