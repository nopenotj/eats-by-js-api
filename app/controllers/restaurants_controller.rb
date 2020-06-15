class RestaurantsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    if params[:q]
      restaurants = Restaurant.search(params[:q])
        .page(params[:page])
        .per(params[:per_page])
      render json: RestaurantSerializer.new(restaurants, meta:{ total_count: Restaurant.count }).serialized_json 
    else
      restaurants = Restaurant.all
        .order('id ASC')
        .page(params[:page])
        .per(params[:per_page])
      render json: RestaurantSerializer.new(restaurants, meta: { total_count: Restaurant.count }).serialized_json 
    end
  end
  def show
    restaurant = Restaurant.find(params[:id])
    render json: RestaurantSerializer.new(restaurant).serialized_json
  end
  def create
    authenticate_request
    if current_user && current_user.isAdmin? 
      @restaurant = Restaurant.create(restaurant_params)
      if @restaurant.valid?
        render status: :created, location: @restaurant
      else
        render json: {errors: @restaurant.errors}
      end
    end
  end
  def update
    authenticate_request
    if current_user && current_user.isAdmin? 
      restaurant = Restaurant.find(params[:id])
      if restaurant.update restaurant_params
        render status: :ok
      else 
        render json: { errors: restaurant.errors }
      end
    end
  end
  def destroy
    authenticate_request
    if current_user && current_user.isAdmin? 
      restaurant = Restaurant.find(params[:id])
      restaurant.destroy
      render status: :ok
    end
  end

  private

  def restaurant_params
    params.require(:data)
      .require(:attributes)
      .permit(
      :title, 
      :description,
      :price,
      :image_link,
      :location,
      :operating_hours,
      :no_of_stalls,
      :closed_on,
      :contact,
      :halal_certified,
    )
  end

end
