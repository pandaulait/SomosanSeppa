class Admin::QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:update]
  layout 'admin'
  def index
    @s_quizzes = SelectionQuiz.all
    @s_quizzes = @s_quizzes.authenticated if params[:sort] == '0'
    @s_quizzes = @s_quizzes.unauthenticated if params[:sort] == '1'
    @d_quizzes = DescriptiveQuiz.all
    @d_quizzes = @d_quizzes.authenticated if params[:sort] == '0'
    @d_quizzes = @d_quizzes.unauthenticated if params[:sort] == '1'
    @quizzes = @s_quizzes + @d_quizzes
    @quizzes = @quizzes.sort{|a,b| a.created_at <=> b.created_at}.reverse
  end

  def show
  end

  private
  # 管理者ユーザー判定
  def admin_user
    return if current_user.admin?

    flash[:alert] = '管理者権限がありません。'
    redirect_to root_path
  end
  # ゲスト管理者判定
  def ensure_normal_admin
    return if current_user.email != 'admin@example.com'

    flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
    redirect_to root_path
  end
end
