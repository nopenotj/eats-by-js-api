class ReviewsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]

  def index
    reviews = get_restaurant.reviews
      .page(params[:page])
      .per(params[:per_page])
    render json: ReviewSerializer.new(reviews).serialized_json
  end

  # GET /products/1
  # GET /products/1.json
  def show
    review = Review.find(params[:id])
    render json: ReviewSerializer.new(review).serialized_json
  end



  # POST /products
  # POST /products.json
  def create
    @review = Review.create(review_params).merge({
      user_id: current_user.id,
      restaurant_id: params[:restaurant_id]
    }) )
    if @review.valid?
      render json: {data: {status: "success"}}
    else
      render json: {errors: @review.errors}
    end
  end

  # PUT /products/1
  # PUT /products/1.json
  def update
  end

  def destroy
  end


  private
  def review_params
    params.require(:data)
      .require(:attributes)
      .permit(
      :title, 
      :content,
      :rating,
    )
  end
  def get_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
end
