class RestaurantSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :rating, :price, :image_link
    attributes :location, :operating_hours, :no_of_stalls, :halal_certified, :closed_on, :contact
    attributes :latitude, &:lat
    attributes :longitude, &:lng

    attribute :distance, if: Proc.new { |record, params|
      params[:lat] && params[:lng]
    }
    attributes :distance do |res, params|
      res.distance_to([params[:lat], params[:lng]])
    end


    has_many :dishes, dependent: :destroy
    has_many :tags 
    has_many :reviews 
  end
