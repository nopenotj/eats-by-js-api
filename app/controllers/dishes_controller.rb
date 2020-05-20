class DishesController < ApplicationController
  def index
    dishes = Dish.all
    render json: DishSerializer.new(dishes).serialized_json
  end
  def show
    dish = Dish.find(params[:id])
    render json: DishSerializer.new(dish).serialized_json
  end
end
