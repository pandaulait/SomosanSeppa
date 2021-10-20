class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!, only: [:index]
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path
    else
      @categories = Category.all
      render :index
    end
  end
  
  def destroy
    category = Category.find(params[:id])
    if category.destroy
      redirect_to admin_categories_path
    else
      @category = category
      @categories  = Category.all
    end
  end
  
  private
  
  def category_params
    params.require(:category).permit(:content)
  end
end
