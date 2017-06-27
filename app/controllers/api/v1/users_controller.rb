module Api::V1
  class UsersController < ApplicationController

    def index
      @users = User.all
    end

    def show

    end
  end
end
