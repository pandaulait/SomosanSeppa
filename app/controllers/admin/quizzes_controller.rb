class Admin::QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:update]
  layout 'admin'
  def index
    @quizzes = Quiz.all.order(created_at: :desc)
  end


  def update
    @quiz = Quiz.find(params[:id])
    @quiz.update(quiz_params)
    redirect_to admin_quiz_path(@quiz)
  end



  def show
    @quiz = Quiz.find(params[:id])
  end


  private
  def quiz_params
    params.require(:quiz).permit(:status)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
  # ゲスト管理者判定
  def ensure_normal_admin
    return if current_user.email != 'admin@example.com'

    flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
    redirect_to request.referer
  end
end
