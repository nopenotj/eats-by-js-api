class RestaurantsController < ApplicationController
  def index
    if params[:q]
      restaurants = Restaurant.search(params[:q])
        .page(params[:page])
        .per(params[:per_page])
      render json: RestaurantSerializer.new(restaurants).serialized_json
    else
      restaurants = Restaurant.all
        .page(params[:page])
        .per(params[:per_page])
      render json: RestaurantSerializer.new(restaurants).serialized_json
    end
  end
  def show
    restaurant = Restaurant.find(params[:id])
    render json: RestaurantSerializer.new(restaurant).serialized_json
  end
  def destroy
    authenticate_request
    if current_user && current_user.isAdmin? 
      restaurant = Restaurant.find(params[:id])
      restaurant.destroy
      render json: { status: 'success' }
    end
  end
end
