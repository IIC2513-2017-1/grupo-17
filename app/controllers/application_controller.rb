class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize(admin=false)
    if admin
      redirect_to '/' unless current_user.is_admin
    else
      redirect_to '/login' unless current_user
    end
  end
end
