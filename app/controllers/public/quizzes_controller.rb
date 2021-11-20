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
    @s_quizzes = SelectionQuiz.all.published.order(created_at: :desc)
    @s_quizzes = @s_quizzes.authenticated if params[:sort] == '0'
    @s_quizzes = @s_quizzes.unauthenticated if params[:sort] == '1'
    @d_quizzes = DescriptiveQuiz.all.published.order(created_at: :desc)
    @d_quizzes = @d_quizzes.authenticated if params[:sort] == '0'
    @d_quizzes = @d_quizzes.unauthenticated if params[:sort] == '1'
    @quizzes = @s_quizzes + @d_quizzes
    @quizzes = @quizzes.sort { |a, b| a.created_at <=> b.created_at }.reverse
  end
end
