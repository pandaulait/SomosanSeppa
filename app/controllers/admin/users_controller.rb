class Admin::UsersController < ApplicationController
  before_action :admin_user
  def index
    @users = User.all
  end
  
  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to(admin_users_path)
  end
  
  private
  
  def admin_user
    redirect_to root_path unless current_user.admin?
  end
  
  def user_params
    params.require(:user).permit(:is_deleted)
  end

end
