# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Restaurant.create([
    {
        title: "Jay's toppokki Restaurant",
        description: "best toppoki in the world",
        rating: 5
    },
    {
        title: "Jerryl's toppokki Restaurant",
        description: "best toppoki in the world",
        rating: 5
    },
    {
        title: "Aerin's toppokki Restaurant",
        description: "worst toppoki in the world",
        rating: 1
    },
])
