class DishesController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    dishes = []
    if params[:restaurant_id].nil?
      dishes = Dish.all 
        .page(params[:page])
        .per(params[:per_page])
    else
      dishes = get_restaurant.dishes
        .page(params[:page])
        .per(params[:per_page])
    end

    render json: DishSerializer.new(dishes).serialized_json
  end
  def show
    dish = Dish.find(params[:id])
    render json: DishSerializer.new(dish).serialized_json
  end
  def create
    authenticate_request
    if current_user && ( current_user.isAdmin? || current_user.restaurant_id.to_i == params[:id].to_i )
      @dish = Dish.create(restaurant_params)
      if @dish.valid?
        render json: DishSerializer.new(dishes).serialized_json,
          location: @dish,
          status: :created
      else
        render json: {errors: @dish.errors}, status: :unprocessable_entity
      end
    end
  end
  def update
    authenticate_request
    if current_user && ( current_user.isAdmin? || current_user.restaurant_id.to_i == params[:id].to_i )
      dish = Dish.find(params[:id])
      if dish.update dish_params
        render json: DishSerializer.new(dishes).serialized_json,
          status: :ok
      else 
        render json: { errors: dish.errors },
          status: :unprocessable_entity
      end
    end
  end
  def destroy
    authenticate_request
    if current_user && ( current_user.isAdmin? || current_user.restaurant_id.to_i == params[:id].to_i )
      dish = Dish.find(params[:id])
      dish.destroy
      render status: :ok
    end
  end

  private
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def dish_params
    params.require(:data)
      .require(:attributes)
      .permit(
      :title, 
      :description,
      :price,
      :restaurant_id
    )
  end
end
