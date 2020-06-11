class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:authenticate]

  def authenticate
    command = AuthenticateUser.call(params[:username], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { errors: command.errors }, status: :unauthorized
    end
  end
end
