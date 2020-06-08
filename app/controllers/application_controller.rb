class ApplicationController < ActionController::API
  attr_reader :current_user

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { errors: 'Not Authorized' }, status: 401 unless @current_user
  end
end
