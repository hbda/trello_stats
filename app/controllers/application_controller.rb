class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: -> { public_acceess? }

  def new_session_path(scope)
    new_user_session_path
  end

  private

  def public_acceess?
    return true if params[:action].include?('example')
    devise_controller?
  end
end
