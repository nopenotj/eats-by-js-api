FactoryBot.define do
  factory :review do
    user { nil }
    restaurant { nil }
    title { "MyString" }
    content { "MyString" }
    rating { 1 }
  end
end
