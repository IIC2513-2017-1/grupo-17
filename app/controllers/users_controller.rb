class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize, except: [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @my_profile = @user==current_user
    friendship = Friendship.where('user_id=:user AND friend_id=:friend OR user_id=:friend AND friend_id=:user',
      user: current_user, friend: @user).first
    if !friendship
      @friendship_status = 'not_friends'
    elsif !friendship.confirmed
      @friendship_status = 'pending_request'
    else
      @friendship_status = 'friends'
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if current_user.is_admin
        safe_params = user_params.merge params.require(:user).permit(:is_admin, :money)
      else
        safe_params = user_params.merge params.require(:user)
        if @user == current_user
          if @user.update(safe_params)
            format.html { redirect_to @user, notice: 'User was successfully updated.' }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
        else
          format.html { redirect_to '/', error: 'You cannot edit other user' }
        end
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user || current_user.is_admin
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      format.html { redirect_to '/', error: 'You cannot destroy a user that is not your own' }
    end
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
