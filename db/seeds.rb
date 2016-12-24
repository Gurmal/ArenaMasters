# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


def seedBackfill(_team)
	i = 0
    while i < (10 - _team.gladiators.count)
        _team.gladiators.create(name: 'T'+_team.id.to_s+' Recruit '+(i+1).to_s)
        i+=1
    end
end

t = Team.create(name:'Flaming Rabble')
Gladiator.create(team_id:t.id, name:'James')
Gladiator.create(team_id:t.id, name:'Spock')
Gladiator.create(team_id:t.id, name:'Bones')
seedBackfill(t)

t2 = Team.create(name:"Bob's Briggands")
	t2.gladiators.create(name:'Luke')
	t2.gladiators.create(name:'Liea')
	t2.gladiators.create(name:'3P0')
seedBackfill(t2)


t3 = Team.create(name:"Lonny's Loaners")
seedBackfill(t3)

Event.create(name:"Test Event 1")


