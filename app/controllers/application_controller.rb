class ApplicationController < ActionController::Base
  # Temporarily disabled this as testing with content_type headers is not going well
  before_action :ensure_json

  def ensure_json
    render json: { message: "Wrong content-type header" }, status: 406 and return unless request.content_type == "application/json"
  end

  # This error rescue code was from a module we did on API's in school, but it looks like we can just use rails config
  # rescue_from ActiveRecord::RecordNotFound, with: :not_found
  # rescue_from StandardError, with: :internal_server_error

  # private

  # def not_found
  #   render json: { error: exception.message }, status: :not_found
  # end

  # def internal_server_error(exception)
  #   if Rails.env.development?
  #     response = { type: exception.class.to_s, error: exception.message }
  #   else
  #     response = { error: "Internal Server Error" }
  #   end
  #   render json: response, status: :internal_server_error
  # end

end
