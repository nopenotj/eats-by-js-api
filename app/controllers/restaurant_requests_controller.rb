class RestaurantRequestsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    requests = RestaurantRequest
      .all
      .page(params[:page])
      .per(params[:per_page])

    render json: serialize(requests)
  end

  def show
    request = RestaurantRequest.find(params[:id])
    render json: RestaurantRequestSerializer.new(request).serialized_json
  end
  def create
    @request = RestaurantRequest.create(res_req_params.merge({
      user_id: current_user.id,
    }))
    if @request.valid?
        render json: serialize(@request),
          location: @request,
          status: :created
    else
        render json: {errors: @request.errors}, status: :unprocessable_entity
    end
  end
  def update
    authenticate_request
    if current_user && current_user.isAdmin? 
      request = RestaurantRequest.find(params[:id])
      if request.update res_req_params
        render json: serialize(request),
          status: :ok
      else 
        render json: { errors: request.errors },
          status: :unprocessable_entity
      end
    end
  end
  def destroy
    authenticate_request
    if current_user && current_user.isAdmin? 
      request = RestaurantRequest.find(params[:id])
      request.destroy
      render status: :ok
    end
  end

  def accept_request
    authenticate_admin
    pp "Succesfully Accepted"
  end

  private

  def serialize(*args)
    requests = args[0]
    loc = args[1]
    RestaurantRequestSerializer.new(requests, {
      params: loc,
    }).serialized_json
  end

  def res_req_params
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
      :lat,
      :lng,
      :tags_id => [],
    )
  end

end
