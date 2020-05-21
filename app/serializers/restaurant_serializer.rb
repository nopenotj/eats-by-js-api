class RestaurantSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :rating

    has_many :dishes, dependent: :destroy
    has_many :tags 
  end
