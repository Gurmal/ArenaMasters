# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

t = Team.create(name:'Flaming Rabble')
Gladiator.create(team_id:t.id, name:'James')
Gladiator.create(team_id:t.id, name:'Spock')
Gladiator.create(team_id:t.id, name:'Bones')

t2 = Team.create(name:"Bob's Briggands")
	t2.gladiators.create(name:'Luke')
	t2.gladiators.create(name:'Liea')
	t2.gladiators.create(name:'3P0')

t3 = Team.create(name:"Lonny's Loaners")