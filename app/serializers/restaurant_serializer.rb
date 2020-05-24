class RestaurantSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :rating, :image_link

    has_many :dishes, dependent: :destroy
    has_many :tags 
    has_many :reviews 
  end
