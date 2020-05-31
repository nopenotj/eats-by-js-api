FactoryBot.define do
  factory :user do
    sequence(:username) { |n|"TestUser#{n}" }
    password { "MyString" }
  end
end
