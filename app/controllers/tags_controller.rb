class TagsController < ApplicationController
    def index
        tags = Tag.all
        render json: TagSerializer.new(tags).serialized_json
    end
    def show
        tag = Tag.find(params[:id])
        render json: TagSerializer.new(tag).serialized_json
    end
end
