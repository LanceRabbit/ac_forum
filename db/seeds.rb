# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.destroy_all

category_list =[
  { name: "商業類" },
  { name: "語文類" },
  { name: "工程類" }
]

category_list.each do |category|
  Category.create( name: category[:name] )
end
puts "Category created!"

User.destroy_all
User.create(email: "admin@example.com", name: "root" , password:"12345678", role:"admin")
puts " #{User.count} users data"

puts "Default admin created!"