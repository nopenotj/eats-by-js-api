FactoryBot.define do
  factory :user do
    sequence(:username) { |n|"TestUser#{n}" }
    password { "MyString" }
    role { 0 }
  end
  factory :restaurant_owner do
    sequence(:username) { |n|"TestRestaurantOwner#{n}" }
    password { "MyString" }
    role { 1 }
  end
  factory :admin_user do
    sequence(:username) { |n|"TestAdminUser#{n}" }
    password { "MyString" }
    role { 2 }
  end
end
