class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:show, :sign_up]

  def index
      users = User.all
        .order('id ASC')
        .page(params[:page])
        .per(params[:per_page])
      render json: serialize(users)
  end
  def show
    render json: {username: User.find(params[:id]).username}
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      render json: serialize(@user),
        status: :ok
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  def update
    if current_user && current_user.isAdmin? 
      user = User.find(params[:id])
      if user.update user_params
        render json: serialize(user),
          status: :ok
      else 
        render json: { errors: user.errors },
          status: :unprocessable_entity
      end
    end
  end

  def sign_up
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

  def serialize(user)
    UserSerializer.new(user, meta: { total_count: User.count }).serialized_json
  end

  def user_params
    params.require(:data)
      .require(:attributes)
      .permit(
        :username,
        :password,
        :role
    )
  end
end
