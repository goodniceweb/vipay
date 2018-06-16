# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [User.find_or_create(first_name: "Victor", last_name: "Makoed", email: "vmakoed@gmail.com", phone: "+375255417247", telegram_id: 62843349),
  User.find_or_create(first_name: "Alex", last_name: "Charkashin", email: "goodniceweb@gmail.com", phone: "+375257089420", telegram_id: 399119104),
  User.find_or_create(first_name: "Tatiana", last_name: "Karpesh", email: "tatiana.karpesh@gmail.com", phone: "+375259038314", telegram_id: 123389695),
  User.find_or_create(first_name: "Kirill", last_name: "LL", email: "kirill@gmail.com", phone: "+375255417247", telegram_id: 62843349)]

party = Party.create(chat_id: -220834405)

users.each do |user|
  Participant.create(user_id: user.id, admin: user.id == 3) 
end
