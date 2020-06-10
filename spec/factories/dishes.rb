FactoryBot.define do
  factory :dish do
    restaurant
    title { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Number.decimal(l_digits: 2)  }
  end
end
