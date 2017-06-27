module Api::V1
  class CategoriesController < ApiController

    def index
      @categories = Category.all
      render json: @categories
    end

  end
end
