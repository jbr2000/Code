# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names = ["Riki", "Megan", "Spencer", "Beau", "Lisa", "Ricky"]

6.times do |i|
  User.create(name: "#{names[i]}", email: "#{i}@gmail.com", password: 'password', password_confirmation: 'password', quote: 'placeholder quote', profile_picture: "user#{i}.jpg")
end

Event.create(title: 'Hittin\' the Bars', creator: User.find(1))
Event.create(title: 'Chico Grad Party', creator: User.find(2))
Event.create(title: 'Riki\'s Birthday Rager', creator: User.find(3))
Event.create(title: 'Mother\'s Day Picnic', creator: User.find(3))
Event.create(title: 'Call of Dudy Night', creator: User.find(4))
Event.create(title: '4th of July BBQ', creator: User.find(4))

Attendee.create(event_id: '1', user_id: '2', status: "1")
Attendee.create(event_id: '1', user_id: '3', status: "2")
Attendee.create(event_id: '1', user_id: '4', status: "3")
Attendee.create(event_id: '1', user_id: '5', status: "1")
Attendee.create(event_id: '2', user_id: '1', status: "1")
Attendee.create(event_id: '2', user_id: '3', status: "1")
Attendee.create(event_id: '3', user_id: '1', status: "1")
Attendee.create(event_id: '3', user_id: '2', status: "1")
Attendee.create(event_id: '3', user_id: '4', status: "1")
Attendee.create(event_id: '3', user_id: '5', status: "1")
Attendee.create(event_id: '3', user_id: '6', status: "1")
