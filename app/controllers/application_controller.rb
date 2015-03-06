class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_sign_in, unless: :devise_controller?

  def after_sign_in_path_for(_user)
    events_path
  end

  private

  def require_sign_in
    return redirect_to new_user_session_path unless user_signed_in?
  end
end
