class Admin::CategoriesController < ApplicationController
  # before_action :authenticate_admin!, only: [:index]
  before_action :authenticate_user!
  before_action :admin_user
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
      @categories = Category.all
    end
  end

  private

  def admin_user
    return if current_user.admin?

    flash[:alert] = '管理者権限がありません。'
    redirect_to root_path
  end

  def category_params
    params.require(:category).permit(:content)
  end
end
