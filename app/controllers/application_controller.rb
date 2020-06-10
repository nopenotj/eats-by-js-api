class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  attr_reader :current_user

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { errors: 'Not Authorized' }, status: 401 unless @current_user
  end

  private

  def record_not_found
    render status: 404
  end
end
