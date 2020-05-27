# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Restaurants
jay_res = Restaurant.create( title: "Jay's toppokki Restaurant", description: "best toppoki in the world", price: 5)
jerryl_res = Restaurant.create( title: "Jerryl's toppokki Restaurant", description: "best toppoki in the world", price: 5)
aer_res = Restaurant.create( title: "Aerin's toppokki Restaurant", description: "worst toppoki in the world", price: 1)

# Dishes
jay_res.dishes.create( title: "jay's toppoki", description: "best toppoki in the world", price: 69) 
jerryl_res.dishes.create( title: "jerryl's toppoki", description: "best toppoki in the world", price: 69)
aer_res.dishes.create( title: "aerin's toppoki", description: "worst toppoki in the world", price: 2)

# Tags
chinese = Tag.create(name: "chinese")
korean = Tag.create(name: "korean")
noodles = Tag.create(name: "noodles")

jay_res.tags << [chinese,korean,noodles]
jerryl_res.tags << [chinese,korean,noodles]
aer_res.tags << [chinese,korean,noodles]

jay_res.update(image_link: "https://letyourheartspeaks.files.wordpress.com/2018/01/image6.jpeg?w=1060" )
jerryl_res.update(image_link: "https://www.capitaland.com/content/dam/capitaland-malaysia-tenants/the-mines/myeongdong-topokki.jpg.transform/cap-lowres/image.jpg" )
aer_res.update(image_link: "https://www.gardeningknowhow.com/wp-content/uploads/2019/04/lawn-pH.jpg" )
