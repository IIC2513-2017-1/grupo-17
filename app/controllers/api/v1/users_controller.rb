module Api::V1
  class UsersController < ApiController
    before_action :authenticate

    def index
      @users = User.all
    end

    def show
      @user = User.includes(:gees).find_by(id: params[:id])
      if @user.nil?
        render json: { error: "User with ID #{params[:id]} does not exists" }
      end
    end
  end
end
