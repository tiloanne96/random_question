class ApplicationController < ActionController::API
	include Pundit::Authorization

	rescue_from Pundit::AuthorizationNotPerformedError, with: :user_not_authorized

	before_action :verify_authorized
	before_action :configure_permitted_parameters, if: :devise_controller?

	def user_not_authorized
    render_error_response(ApiExceptions::BaseException.new(:UNAUTHORIZED, [], {}))
  end

	def render_error_response(error)
    render json: error, serializer: ApiExceptionSerializer, status: 502
  end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: %i[name])
		devise_parameter_sanitizer.permit(:account_update, keys: %i[name])
	end
end
