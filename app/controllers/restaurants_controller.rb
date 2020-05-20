class RestaurantsController < ActionController::API
    def index
        restaurants = Restaurant.all
        render json: RestaurantSerializer.new(restaurants).serialized_json
    end
    def show
        restaurant = Restaurant.find(params[:id])
        render json: RestaurantSerializer.new(restaurant).serialized_json
    end
end
