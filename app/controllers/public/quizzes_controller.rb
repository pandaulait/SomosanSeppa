class Public::QuizzesController < ApplicationController
  before_action :authenticate_user!
  # とりえず一問　そもさん
  def somosan; end

  # とりえず一問　せっぱ
  def seppa
    @quiz = Quiz.randomly_selected(current_user)
  end

  # クイズ一覧
  def index
    @quizzes = SelectionQuiz.all.published + DescriptiveQuiz.all.published
    @quizzes = @quizzes.sort{|a,b| a.created_at <=> b.created_at}.reverse
  end
end
