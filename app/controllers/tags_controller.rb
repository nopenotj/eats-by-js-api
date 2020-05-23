class TagsController < ApplicationController
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

    def get_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
