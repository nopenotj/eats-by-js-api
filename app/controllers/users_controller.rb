class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:show, :create, :profile]

  def show
    render json: {username: User.find(params[:id]).username}
  end
  def create
    @user = User.create(user_params.merge({role: 0}))
    if @user.valid?
      render status: :ok
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  def profile
    render json: UserSerializer.new(current_user).serialized_json unless current_user.nil?
  end

  private

  def user_params
    params.require(:data)
      .require(:attributes)
      .permit(
        :username,
        :password
    )
  end
end
