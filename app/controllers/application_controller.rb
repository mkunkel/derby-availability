class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :flash_to_arrays
  before_action :require_sign_in, unless: :devise_controller?

  def after_sign_in_path_for(_user)
    events_path
  end

  private

  def flash_to_arrays
    flash.keys.each { |key| flash[key] = Array(flash[key]) }
  end

  def add_flash(key, value)
    if flash[key]
      flash[key] << value
    else
      flash[key] = [value]
    end
  end

  def require_sign_in
    return if user_signed_in?

    add_flash(:alert, 'You must be logged in to do that.')
    redirect_to new_user_session_path
  end
end
