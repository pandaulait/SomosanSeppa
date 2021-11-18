class Public::QuizzesController < ApplicationController
  # とりえず一問　そもさん
  def somosan; end

  # とりえず一問　せっぱ
  def seppa
    @quiz = Quiz.randomly_selected(current_user)
  end
end
