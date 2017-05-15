class FriendshipsController < ApplicationController
  before_action :set_user, only: [:send_request, :accept_request, :destroy]
  before_action :require_login

  def list
    @requesters = User.joins("INNER JOIN friendships ON users.id=friendships.user_id")
      .where(friendships: { confirmed: false, friend: current_user })
  end

  def send_request
    friendship = current_user.friendships.new(friend: @user, confirmed: false)

    respond_to do |format|
      if friendship.save
        format.html { redirect_back fallback_location: '/', notice: 'Your request was sent.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_back fallback_location: '/', flash: { error: friendship.errors } }
        format.json { render json: friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def accept_request
    friendship = current_user.friendships.new(friend: @user, confirmed: true)

    respond_to do |format|
      if friendship.save
        request_friendship = Friendship.where(user: @user, friend: current_user).first
        request_friendship.confirmed = true
        request_friendship.save

        format.html { redirect_back fallback_location: '/', notice: "You and #{@user.username} are now friends." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_back fallback_location: '/', flash: { error: friendship.errors } }
        format.json { render json: friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    friendships = Friendship.where('user_id=:user AND friend_id=:friend OR user_id=:friend AND friend_id=:user',
      user: current_user.id, friend: @user.id)

    respond_to do |format|
      if friendships.destroy_all
        format.html { redirect_back fallback_location: '/', notice: "You and #{@user.username} are no longer friends." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { redirect_back fallback_location: '/', flash: { error: friendship.errors } }
        format.json { render json: friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friendship_params
      params.require(:user)
    end
end
