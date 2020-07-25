class RestaurantRequestSerializer
    include FastJsonapi::ObjectSerializer
    attributes :title, :description, :price, :image_link
    attributes :location, :operating_hours, :no_of_stalls, :halal_certified, :closed_on, :contact
    attributes :latitude, &:lat
    attributes :longitude, &:lng
    attributes :state


    attributes :distance ,if: Proc.new { |record, params|
      params && !params[:lat].nil? && !params[:lng].nil?
    } do |res, params|
      res.distance_to([params[:lat], params[:lng]])
    end
  end
