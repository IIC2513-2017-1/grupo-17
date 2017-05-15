class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    friendship = Friendship.where('user_id=:user AND friend_id=:friend OR user_id=:friend AND friend_id=:user',
      user: current_user, friend: @user).first
    if friendship.nil?
      @friendship_status = 'not_friends'
    elsif friendship.confirmed
      @friendship_status = 'friends'
    else
      @friendship_status = 'pending_request'
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user == current_user or current_user.is_admin
      render :edit
    else
      redirect_to root_path
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    safe_params = user_params
    if current_user.is_admin
      safe_params = safe_params.merge params.require(:user).permit(:is_admin, :money)
    end
    if @user == current_user or current_user.is_admin
      if @user.update(safe_params)
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render :edit
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /users/1
  def destroy
      @user.destroy
      redirect_to users_path, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
