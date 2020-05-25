class ReviewSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :content, :rating, :created_at
    has_one :restaurant
    has_one :user
  end
