class DishesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    dishes = []
    if params[:restaurant_id].nil?
      dishes = Dish.all 
    else
      dishes = get_restaurant.dishes
    end

    render json: DishSerializer.new(dishes).serialized_json
  end
  def show
    dish = Dish.find(params[:id])
    render json: DishSerializer.new(dish).serialized_json
  end

  private
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
