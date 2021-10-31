class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user)
  end

  private
  def ensure_correct_user
    user = User.find(params[:id])
    return if user == current_user

    flash[:alert] = '他人のコラムは編集できません。'
    redirect_to request.referer
    
  end
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
