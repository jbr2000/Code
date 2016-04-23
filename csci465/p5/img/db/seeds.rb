# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(id: 1, name: "test", email: "test@test.com", password: "password", password_confirmation: "password")
User.create(id: 2, name: "user2", email: "test2@test.com", password: "password", password_confirmation: "password")
User.create(id: 3, name: "user3", email: "test3@test.com", password: "password", password_confirmation: "password")



Image.create(id: 1, filename: "1.jpg", user_id: 1, public: 1)
Image.create(id: 2, filename: "2.jpg", user_id: 2, public: 0)
Image.create(id: 3, filename: "3.jpg", user_id: 2, public: 0)
Image.create(id: 4, filename: "4.jpg", user_id: 1, public: 0)

Tag.create(image_id: 1, value: "Forrest")
Tag.create(image_id: 1, value: "Plains")


Imageuser.create(user_id: 1, image_id: 3)