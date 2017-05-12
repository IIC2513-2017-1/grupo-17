class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where('username=:query OR email=:query', query: params[:username]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:notice] = 'User doesn\'t exists or the information doesn\'t match'
      render :new
    end

  end

  def destroy
    session[:user_id] = nil
    #TODO: Show message
    redirect_to '/login'
  end
end
