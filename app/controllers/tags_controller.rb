class TagsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index, :show]
    def index
      tags = []
      if !params[:filter].nil?
        hash = JSON.parse params[:filter]
        pp hash["id"]
        tags = Tag.where(id: hash["id"])
      elsif params[:restaurant_id].nil?
        tags = Tag.all
      else
        tags = get_restaurant.tags
      end
      render json: TagSerializer.new(tags, meta: {total_count: Tag.count}).serialized_json
    end

    def create
        if current_user && current_user.isAdmin? 
          @tag = Tag.create(name: tag_params[:name].downcase)
          if @tag.valid?
            render json: TagSerializer.new(@tag).serialized_json,
              location: @tag,
              status: :created
          else
            render json: {errors: @tag.errors}, status: :unprocessable_entity
          end
        end
    end

    def show
        tag = Tag.find(params[:id])
        render json: TagSerializer.new(tag).serialized_json
    end

    private 

    def tag_params
      params.require(:data)
        .require(:attributes)
        .permit(
          :name, 
      )
    end

    def get_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
