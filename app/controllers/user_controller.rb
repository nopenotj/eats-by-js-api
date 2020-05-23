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
    render json: {"ok": current_user}
  end
end
