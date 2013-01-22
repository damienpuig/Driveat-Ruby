# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'

user = User.create! :username => 'Damien PUIG', :email => 'damien.puig@gmail.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
user2 = User.create! :username => 'Thibault LAURENS', :email => 'thibault.laurens@gmail.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user2.name