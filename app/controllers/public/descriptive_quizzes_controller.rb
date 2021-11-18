class Public::DescriptiveQuizzesController < ApplicationController
  before_action :authenticate_user!
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

  # phase3に到達しているかどうか
  def reach_phase3
    return if current_user.reach_phase?(3)

    flash[:alert] = '記述式クイズの作成ができるのはレベルが15以上になってからです。たくさんクイズを解きましょう。'
    redirect_to root_path
  end
end
