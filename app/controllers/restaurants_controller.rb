class RestaurantsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index

    restaurants = search_query_present? ? Restaurant.search(params[:q]) : Restaurant.all
    restaurants = location_present? ? restaurants.sort_by{|s| s.distance_to([params[:lat],params[:lng]])} : restaurants
    restaurants = params[:sort_by].present? && !location_present? ? restaurants.order(params[:sort_by]) : restaurants.order('id ASC')

    if params[:tags_id].present?
      tags = JSON.parse params[:tags_id]

      restaurants = restaurants.filter {|res| 
        resTags = res.tags.map(&:id)
        tags.all? { |e| resTags.include?(e.to_i) }
      }
      restaurants = Kaminari.paginate_array(restaurants)
    else
      restaurants = location_present? ? Kaminari.paginate_array(restaurants) : restaurants
    end



    restaurants = restaurants
      .page(params[:page])
      .per(params[:per_page])

    if location_present?
      render json: serialize(restaurants, { lat: params[:lat], lng: params[:lng], })
    else
      render json: serialize(restaurants)
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
      if restaurant.update restaurant_params.except(:tags_id)
        restaurant.tags.delete_all
        restaurant.tags << restaurant_params[:tags_id].map { |s| Tag.find(s)}
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

  def search_query_present?
    params[:q] && !params[:q].empty? 
  end
  def location_present?
    params[:lat] && params[:lng]
  end

  def serialize(*args)
    restaurant = args[0]
    loc = args[1]
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
      :tags_id => [],
    )
  end

end
