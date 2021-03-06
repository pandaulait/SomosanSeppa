class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, except: [:show, :confirm]
  before_action :ensure_normal_user, only: [:update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @user.all_read_leveled_up
    @quizzes = @user.selection_quizzes.published + @user.descriptive_quizzes.published
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    redirect_to user_path(@user) if @user.update(user_params)
  end

  def confirm
    
  end

  def destroy
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = 'ありがとうございました。またのご利用を心よりお待ちしております。'
    redirect_to root_path
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
