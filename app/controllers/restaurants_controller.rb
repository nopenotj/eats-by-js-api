class RestaurantsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    if params[:q] && !params[:q].empty? 
      restaurants = Restaurant.search(params[:q])
        .page(params[:page])
        .per(params[:per_page])
      if params[:lat] && params[:lng]
        render json: serialize(
          restaurants.sort_by{|s| s.distance_to([params[:lat],params[:lng]])},
          {
            lat: params[:lat],
            lng: params[:lng],
          }
        ) 
      else
        render json: serialize(restaurants)
      end
    else
      restaurants = Restaurant.all
        .order('id ASC')
        .page(params[:page])
        .per(params[:per_page])
      if params[:lat] && params[:lng]
        render json: serialize(
          restaurants.sort_by{|s| s.distance_to([params[:lat],params[:lng]])},
          {
            lat: params[:lat],
            lng: params[:lng],
          }
        ) 
      else
        render json: serialize(restaurants)
      end
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
        render json: serialize(@restaurant),
          location: @restaurant,
          status: :created
      else
        render json: {errors: @restaurant.errors}, status: :unprocessable_entity
      end
    end
  end
  def update
    authenticate_request
    if current_user && current_user.isAdmin? 
      restaurant = Restaurant.find(params[:id])
      if restaurant.update restaurant_params
        render json: serialize(restaurant),
          status: :ok
      else 
        render json: { errors: restaurant.errors },
          status: :unprocessable_entity
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

  def add_tag
    restaurant = Restaurant.find(params[:id])
    tag = Tag.find_or_create_by(name: params[:name])
    restaurant.tags << tag
  end

  private

  def serialize(restaurant, loc)
    RestaurantSerializer.new(restaurant, {
      params: loc,
      meta: { total_count: Restaurant.count }
    }).serialized_json
  end

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
