# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
users = [
  User.find_or_create_by(
    first_name: "Victor",
    last_name: "Makoed",
    email: "vmakoed@gmail.com",
    phone: "+375255417247",
    username: "vmakoed",
    telegram_id: 62843349
  ),
  User.find_or_create_by(
    first_name: "Alex",
    last_name: "Charkashin",
    email: "goodniceweb@gmail.com",
    phone: "+375257089420",
    username: "goodniceweb",
    telegram_id: 399119104
  ),
  User.find_or_create_by(
    first_name: "Tatiana",
    last_name: "Karpesh",
    email: "tatiana.karpesh@gmail.com",
    phone: "+375259038314",
    username: "tkarpesh",
    telegram_id: 123389695
  ),
  User.find_or_create_by(
    first_name: "Kirill",
    last_name: "LL",
    email: "kirill@gmail.com",
    phone: "+375255417247",
    telegram_id: 183569785
  )
]

party = Party.where(chat_id: -220834405, total: "245.60").first_or_create

users.each do |user|
  Participant.find_or_create_by(user_id: user.id, admin: user.id == 3, party_id: party.id)
end

items = [{:amount=>2, :name=>"potato", :price=>"50", :total=>"100"},
 {:amount=>1, :name=>"cola", :price=>"5.60", :total=>"5.60"},
 {:amount=>1, :name=>"pizza", :price=>"40", :total=>"40"}]

items.each do |item|
  Item.where(item.merge(party_id: party.id)).first_or_create
end
