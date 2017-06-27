module Api::V1
  class UsersController < ApiController
    before_action :authenticate

    def index
      @users = User.all
    end

    def show
      @user = User.includes(:gees).find(params[:id])
    end
  end
end
