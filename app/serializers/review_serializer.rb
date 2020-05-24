class ReviewSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :content, :rating
    has_one :restaurant
    has_one :user
  end
