class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user
  before_action :ensure_normal_user, only: [:update]
  def show
    @user = User.find(params[:id])
    @user.all_read_level
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    redirect_to user_path(@user) if @user.update(user_params)
  end

  private

  # 編集されるユーザーとcurrent_userが同じかどうか
  def ensure_correct_user
    user = User.find(params[:id])
    return if user == current_user

    flash[:alert] = '他人のデータは編集できません。'
    redirect_to root_path
  end

  # ゲストユーザー判定
  def ensure_normal_user
    return if current_user.email != 'guest@example.com'

    flash[:alert] = 'ゲストユーザーでは、アカウント情報の変更はできません。'
    redirect_to edit_user_path(current_user)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
