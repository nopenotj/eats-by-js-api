class DishesController < ApplicationController

  def index
    dishes = get_restaurant.dishes
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
