class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:update]
  layout 'admin'
  def index
    @users = User.all
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to(admin_users_path)
  end

  private

  # 管理者ユーザー判定
  def admin_user
    return if current_user.admin?

    flash[:alert] = '管理者権限がありません。'
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:is_deleted)
  end

  # ゲスト管理者判定
  def ensure_normal_admin
    return if current_user.email != 'admin@example.com'

    flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
    redirect_to request.referer
  end
end
