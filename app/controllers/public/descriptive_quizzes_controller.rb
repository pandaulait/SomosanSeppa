class Public::DescriptiveQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[edit update]
  before_action :ensure_normal_admin, only: %i[update]
  before_action :ensure_today_quiz, only: %i[edit update]
  before_action :reach_phase3, only: %i[new create edit update]
  def new
    @quiz = DescriptiveQuiz.new
  end

  def create
    @quiz = DescriptiveQuiz.new(descriptive_quizzes_params)
    @quiz.user_id = current_user.id
    if @quiz.save
      redirect_to descriptive_quiz_path(@quiz)
    else
      flash.now[:alert] = '保存に失敗しました。'
    end
  end

  def show
    @quiz = DescriptiveQuiz.find(params[:id])
    @result = @quiz.results.new
  end

  def index; end

  def edit
    @quiz = DescriptiveQuiz.find(params[:id])
  end

  def update
    @quiz = DescriptiveQuiz.find(params[:id])
    @quiz.status = 'unauthenticated' if @quiz.status == 'authenticated'
    if @quiz.update(descriptive_quizzes_params)
      redirect_to descriptive_quiz_path(@quiz)
    else
      flash.now[:alert] = '更新に失敗しました。'
    end
  end

  def image_desttroy
    quiz = DescriptiveQuiz.find(params[:id])
    quiz.image.purge
    redirect_to edit_descriptive_quiz_path(quiz)
  end

  private

  def descriptive_quizzes_params
    params.require(:descriptive_quiz).permit(:content, :image, :explanation)
  end

  # ゲスト管理者でないか
  def ensure_normal_admin
    unless (current_user.email == 'admin@example.com') and (DescriptiveQuiz.find(params[:id]).user != current_user)
      return
    end

    flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
    redirect_to descriptive_quiz_path(DescriptiveQuiz.find(params[:id]))
  end

  # current_userとクイズの作者が一致しているかどうか
  def ensure_correct_user
    user = DescriptiveQuiz.find(params[:id]).user
    return if user == current_user || current_user.admin?

    flash[:alert] = '他人のクイズは編集できません。'
    redirect_to root_path
  end

  # その問いが今日の5問に選ばれているかどうか。選ばれていればリダイレクト
  def ensure_today_quiz
    return unless DescriptiveQuiz.find(params[:id]).today_quizzes.find_by(content: Date.today).present?
    return if current_user.email == 'pandaulait73@gmail.com'

    flash[:alert] = '今日の5問に選ばれているため、編集ができません。また後日編集するか、新規作成を行ってください。'
    redirect_to descriptive_quiz_path(DescriptiveQuiz.find(params[:id]))
  end

  # phase3に到達しているかどうか
  def reach_phase3
    return if current_user.reach_phase?(3)

    flash[:alert] = '記述式クイズの作成ができるのはレベルが15以上になってからです。たくさんクイズを解きましょう。'
    redirect_to root_path
  end
end
