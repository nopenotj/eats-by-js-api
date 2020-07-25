# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# # Restaurants
# jay_res = Restaurant.create( title: "Jay's toppokki Restaurant", description: "best toppoki in the world", price: 5)
# jerryl_res = Restaurant.create( title: "Jerryl's toppokki Restaurant", description: "best toppoki in the world", price: 5)
# aer_res = Restaurant.create( title: "Aerin's toppokki Restaurant", description: "worst toppoki in the world", price: 1)
# 
# # Dishes
# jay_res.dishes.create( title: "jay's toppoki", description: "best toppoki in the world", price: 69) 
# jerryl_res.dishes.create( title: "jerryl's toppoki", description: "best toppoki in the world", price: 69)
# aer_res.dishes.create( title: "aerin's toppoki", description: "worst toppoki in the world", price: 2)
# 
# # Tags
# chinese = Tag.create(name: "chinese")
# korean = Tag.create(name: "korean")
# noodles = Tag.create(name: "noodles")
# 
# jay_res.tags << [chinese,korean,noodles]
# jerryl_res.tags << [chinese,korean,noodles]
# aer_res.tags << [chinese,korean,noodles]
# 
# jay_res.update(image_link: "https://letyourheartspeaks.files.wordpress.com/2018/01/image6.jpeg?w=1060" )
# jerryl_res.update(image_link: "https://www.capitaland.com/content/dam/capitaland-malaysia-tenants/the-mines/myeongdong-topokki.jpg.transform/cap-lowres/image.jpg" )
# aer_res.update(image_link: "https://www.gardeningknowhow.com/wp-content/uploads/2019/04/lawn-pH.jpg" )


# {
# "title"=>"Arise & Shine", 
# "image_link"=>"https://uci.nus.edu.sg/oca/wp-content/uploads/sites/9/2018/05/E4-Arise-n-Shine-2-1024x768.jpg", 
# "location"=>"Engineering Block E4", 
# "operating_hours"=>"Mon-Fri, 7.00am-8.00pm\nSat/Sun/PH, 7.00am-3.00pm", 
# "no_of_stalls"=>"N/A", "halal_certified"=>false, 
# "closed_on"=>"N/A", 
# "contact"=>"N/A"
# }

# file = File.read('./db/restaurants_data.json')
# data_hash = JSON.parse(file)
# data_hash["restaurants_data"].each { |restaurant|
#   res = Restaurant.create( 
#                           title: restaurant["title"],
#                           image_link: restaurant["image_link"],
#                           description: Faker::Restaurant.description, 
#                           location: restaurant["location"],
#                           operating_hours: restaurant["operating_hours"],
#                           no_of_stalls: restaurant["no_of_stalls"],
#                           halal_certified: restaurant["halal_certified"],
#                           closed_on: restaurant["closed_on"],
#                           contact: restaurant["contact"],
#                           price: 5
#                          )
# }
# 
# 
# 
# file = File.read('./db/UT_restaurant_data.json')
# data_hash = JSON.parse(file)
# data_hash["restaurants_data"].each { |restaurant|
#   res = Restaurant.create( 
#                           title: restaurant["title"],
#                           image_link: restaurant["image_link"],
#                           description: Faker::Restaurant.description, 
#                           location: restaurant["location"],
#                           operating_hours: restaurant["operating_hours"],
#                           no_of_stalls: restaurant["no_of_stalls"],
#                           halal_certified: restaurant["halal_certified"],
#                           closed_on: restaurant["closed_on"],
#                           contact: restaurant["contact"],
#                           price: 5
#                          )
# }

# #load the excel file
# excel_file = Roo::Spreadsheet.open('./db/eats_by_js_restaurant_data.xlsx')
# #navigate to specific sheet
# excel_file.sheet(0)
# #select row range you wish to iterate over
# 2.upto(56) do |line|
#   title = excel_file.cell(line, 'B')
#   description = excel_file.cell(line, 'C')
#   price = excel_file.cell(line, 'E')
#   image_link = excel_file.cell(line, 'F')
#   location = excel_file.cell(line, 'G')
#   operating_hours = excel_file.cell(line, 'H')
#   no_of_stalls = excel_file.cell(line, 'I')
#   halal_certified = excel_file.cell(line, 'J')
#   closed_on = excel_file.cell(line, 'K') == "N/A" ? nil : excel_file.cell(line, 'K')
#   latitude = excel_file.cell(line, 'L')
#   longitude = excel_file.cell(line, 'M')
# 
#  Restaurant.create!(
#    title: title, 
#    description: description,
#    price: price,
#    image_link: image_link,
#    location: location,
#    operating_hours: operating_hours,
#    no_of_stalls: no_of_stalls,
#    halal_certified: halal_certified,
#    closed_on: closed_on,
#    lat: latitude,
#    lng: longitude,
#  )
# end

# remember delete lol
# admin_user = User.create(username:"admin", password:"admin", role: 2)

file = File.read('./db/other_stores_data.json')
data_hash = JSON.parse(file)
data_hash["stores_data"].each { |restaurant|
  res = Restaurant.create( 
                          title: restaurant["title"],
                          image_link: restaurant["image_link"],
                          description: Faker::Restaurant.description, 
                          location: restaurant["location"],
                          operating_hours: restaurant["operating_hours"],
                          no_of_stalls: restaurant["no_of_stalls"],
                          halal_certified: restaurant["halal_certified"],
                          closed_on: restaurant["closed_on"],
                          contact: restaurant["contact"],
                          price: rand(5..20),
                          lat: restaurant["latitude"],
                          lng: restaurant["longitude"],
                         )
}
