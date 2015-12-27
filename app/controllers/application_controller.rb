class ApplicationController < ActionController::Base
  include Pundit
  require 'pocket_api'
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  def after_sign_in_path_for(resource)
    PocketApi.configure(client_key: ENV["POCKET_CONSUMER_KEY"], access_token: session[:access_token])
    user_path(current_user)
  end

  protected
  def user_not_authorized
    flash[:alert] = "Sorry, you're not authorized to do that."
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
