class RestaurantsController < ApplicationController
  def index
    if params[:q]
      restaurants = Restaurant.search(params[:q])
        .page(params[:page])
        .per(params[:per_page])
      render json: RestaurantSerializer.new(restaurants).serialized_json
    else
      restaurants = Restaurant.all
        .order('id ASC')
        .page(params[:page])
        .per(params[:per_page])
      render json: RestaurantSerializer.new(restaurants).serialized_json
    end
  end
  def show
    restaurant = Restaurant.find(params[:id])
    render json: RestaurantSerializer.new(restaurant).serialized_json
  end
  def update
    authenticate_request
    if current_user && current_user.isAdmin? 
      restaurant = Restaurant.find(params[:id])
      if restaurant.update article_params
          render json: { status: 'success' }
      else 
        render json: { error: restaurant.errors }
      end
    end
  end
  def destroy
    authenticate_request
    if current_user && current_user.isAdmin? 
      restaurant = Restaurant.find(params[:id])
      restaurant.destroy
      render json: { status: 'success' }
    end
  end

  private

  def article_params
    params.require(:restaurant).permit(
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
