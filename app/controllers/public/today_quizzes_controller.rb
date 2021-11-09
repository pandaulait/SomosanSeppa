class Public::TodayQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_finished_today_quiz
  def index
    # 今日の五問がなければ作る
    TodayQuiz.five_create unless TodayQuiz.five_created?
    # 次の問題
    today_quizzes = TodayQuiz.where(content: Date.today)
    @number = current_user.today_status
    @quiz = today_quizzes[@number].quiz
    @choices = @quiz.choices
    @result = TodayResult.new
    # byebug
  end

  def somosan; end

  def seppa; end

  private

  # 今日、今日の五問に挑戦しているか
  def ensure_finished_today_quiz
    unless TodayResult.all.where('created_at >= ?', Date.today).where(user_id: current_user.id).present?
      current_user.update(today_status: 0)
    end
    return unless current_user.finish_today_quizzes?

    redirect_to today_results_path
  end
end
