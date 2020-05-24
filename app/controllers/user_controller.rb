class UserController < ApplicationController
  def create
    @user = User.create(params.require(:user).permit(:username,:password))
    if @user.valid?
      render json: {data: {status: "success"}}
    else
      render json: {errors: @user.errors}
    end
  end

  def profile
    authenticate_request
    render json: UserSerializer.new(current_user).serialized_json unless current_user.nil?
  end
end
