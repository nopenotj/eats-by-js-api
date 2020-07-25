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

  def create
    authenticate_request
    if current_user && ( current_user.isAdmin? || current_user.restaurant_id.to_i == params[:id].to_i )
      @deal = Deal.create(deal_params)
      if @deal.valid?
        render json: DealSerializer.new(@deal).serialized_json,
          location: @deal,
          status: :created
      else
        render json: {errors: @deal.errors}, status: :unprocessable_entity
      end
    end
  end
  def update
    authenticate_request
    if current_user && ( current_user.isAdmin? || current_user.restaurant_id.to_i == params[:id].to_i )
      deal = Deal.find(params[:id])
      if deal.update deal_params
        render json: DealSerializer.new(deal).serialized_json,
          status: :ok
      else 
        render json: { errors: deal.errors },
          status: :unprocessable_entity
      end
    end
  end
  def destroy
    authenticate_request
    if current_user && ( current_user.isAdmin? || current_user.restaurant_id.to_i == params[:id].to_i )
      deal = Deal.find(params[:id])
      deal.destroy
      render status: :ok
    end
  end

  private
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
  def deal_params
    params.require(:data)
      .require(:attributes)
      .permit(
      :title, 
      :description,
      :start_time,
      :end_time,
      :restaurant_id
    )
  end
end
