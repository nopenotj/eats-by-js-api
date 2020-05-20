class RestaurantSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :rating
  end
