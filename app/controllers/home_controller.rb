class HomeController < ApplicationController
  # GET /
  def index
    redirect_to new_user_session_path
  end
end
