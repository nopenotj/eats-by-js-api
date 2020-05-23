class RestaurantsController < ApplicationController
  def index
    pp request.authorization()
    restaurants = Restaurant.all
      .page(params[:page])
      .per(params[:per_page])
    render json: RestaurantSerializer.new(restaurants).serialized_json
  end
  def show
    restaurant = Restaurant.find(params[:id])
    render json: RestaurantSerializer.new(restaurant).serialized_json
  end
end
