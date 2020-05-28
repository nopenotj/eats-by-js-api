class RestaurantSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :rating, :price, :image_link
    attributes :location, :operating_hours, :no_of_stalls, :halal_certified, :closed_on, :contact

    has_many :dishes, dependent: :destroy
    has_many :tags 
    has_many :reviews 
  end
