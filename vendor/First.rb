require_relative 'gladiator'
require_relative 'fight'

myteam = Team.new("Flaming Rabble")
kirk = Gladiator.new("Kirk",2)
myteam.hire(kirk)
myteam.backfill(2)
puts myteam

yourteam = Team.new("Ice Monsters")
newhire = Gladiator.new("Spock",1)
yourteam.hire(newhire)
newhire = Gladiator.new("Gorn",2)
yourteam.hire(newhire)
puts yourteam

#trial = Fight.new(kirk,spock)
#trial.run
#SparticusLives

FridayFight = Event.new("Gladiator Mania!!!", '1/31/2008',myteam,yourteam)
FridayFight.buildSchedule
FridayFight.run

puts
puts myteam
puts yourteam