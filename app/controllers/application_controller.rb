class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_path, alert: exception.message }
      format.json { render json: { message: exception.message }, status: :forbidden }
      format.js do
        @message = exception.message
        render 'common/not_authorized'
      end
    end
  end

  check_authorization unless :devise_controller?
end
