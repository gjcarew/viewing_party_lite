# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create!(id: 1, name: "Demo user", email: "demo@user.com")
user2 = User.create!(id: 2, name: "Friend 1", email: "friend1@user.com")
user3 = User.create!(id: 3, name: "Friend 2", email: "friend2@user.com")
user4 = User.create!(id: 4, name: "Friend 3", email: "friend3@user.com")
user5 = User.create!(id: 5, name: "Friend 4", email: "friend4@user.com")
