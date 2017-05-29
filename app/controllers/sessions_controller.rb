class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where('username=:query OR email=:query', query: params[:username]).first
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to user and return
      else
        flash[:notice] = 'You have to confirm your email before log in.'
      end
    else
      flash[:notice] = 'User doesn\'t exists or the information doesn\'t match.'
    end
    render :new
  end

  def destroy
    session[:user_id] = nil
    #TODO: Show message
    redirect_to login_path
  end
end
