class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where('username=:query OR email=:query', query: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      #TODO: Show error
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    #TODO: Show message
    redirect_to '/login'
  end
end
