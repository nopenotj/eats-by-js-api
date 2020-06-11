class TagsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
    def index
      tags = []
      if params[:restaurant_id].nil?
        tags = Tag.all
      else
        tags = get_restaurant.tags
      end
      render json: TagSerializer.new(tags).serialized_json
    end

    def show
        tag = Tag.find(params[:id])
        render json: TagSerializer.new(tag).serialized_json
    end

    private 

    def get_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
