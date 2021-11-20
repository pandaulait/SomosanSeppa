class Admin::DescriptiveQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:update]
  layout 'admin'

  def show
    @quiz = DescriptiveQuiz.find(params[:id])
  end

  def update
    @quiz = DescriptiveQuiz.find(params[:id])
    @quiz.update(descriptive_quiz_params)
    redirect_to admin_descriptive_quiz_path(@quiz)
  end

  private

  def descriptive_quiz_params
    params.require(:descriptive_quiz).permit(:status)
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
