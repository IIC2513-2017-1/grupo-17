class CategoriesController < ApplicationController
  before_action :authorize

  # GET /categories
  def index
    @categories = Category.all
    @category = Category.new
  end


  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_url, notice: 'Category was successfully created.'
    else
      render :index
    end
  end

  # DELETE /categories/1
  def destroy
    @category = Category.find(params[:id])
    if Gee.where(category: @category).count > 0
      msg = 'Category was not destroyed because it is being used as a foreign key in a Gee.'
    else
      @category.destroy
      msg = 'Category was successfully destroyed.'
    end
    redirect_to categories_url, notice: msg
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
