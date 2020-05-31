FactoryBot.define do
  factory :restaurant do
    title { Faker::Restaurant.name }
    description { Faker::Restaurant.description }
    price { Faker::Number.decimal(l_digits: 2) } 
    image_link { "www.google.com/" }
    location { "U Town Pantry" }
    operating_hours { "Monday - Friday : 6.pm. - 9 p.m." }
    no_of_stalls { Faker::Number.within(range: 1..20) }
    closed_on { "1111" }
    contact { Faker::PhoneNumber.phone_number_with_country_code }
    halal_certified { true }

    trait :with_dish do
      after(:create) do |instance|
        create_list :dish, 1, restaurant: instance
      end
    end
      
    trait :with_review do
      after(:create) do |instance|
        create_list :review, 1, restaurant: instance
      end
    end
  end
end
