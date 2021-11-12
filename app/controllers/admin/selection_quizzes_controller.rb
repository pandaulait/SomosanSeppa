class Admin::SelectionQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:update]
  layout 'admin'
  def index
    @quizzes = SelectionQuiz.all.order(created_at: :desc)
    @quizzes = @quizzes.authenticated if params[:sort] == '0'
    @quizzes = @quizzes.unauthenticated if params[:sort] == '1'
  end

  def update
    @quiz = SelectionQuiz.find(params[:id])
    @quiz.update(selection_quiz_params)
    redirect_to admin_quiz_path(@quiz)
  end

  def show
    @quiz = SelectionQuiz.find(params[:id])
  end

  private

  def selection_quiz_params
    params.require(:selection_quiz).permit(:status)
  end

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
