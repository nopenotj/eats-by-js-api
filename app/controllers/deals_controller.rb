class DealsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    deals = []
    if params[:restaurant_id].nil?
      deals = Deal.all 
        .page(params[:page])
        .per(params[:per_page])
    else
      deals = get_restaurant.deals
        .page(params[:page])
        .per(params[:per_page])
    end

    render json: DealSerializer.new(deals).serialized_json
  end
  def show
    deal = Deal.find(params[:id])
    render json: DealSerializer.new(deal).serialized_json
  end

  private
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
