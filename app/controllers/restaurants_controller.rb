class RestaurantsController < ActionController::API
    def index
        restaurants = Restaurant.all
        render json: RestaurantSerializer.new(restaurants).serialized_json

    end
end