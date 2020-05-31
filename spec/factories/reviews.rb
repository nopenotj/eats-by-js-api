FactoryBot.define do
  factory :review do
    user { nil }
    restaurant { nil }
    sequence(:title) {|n| "review #{n}"}
    content { Faker::Restaurant.review }
    rating { Faker::Number.within(range: 0..5) }
  end
end
