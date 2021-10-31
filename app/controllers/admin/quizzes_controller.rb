class Admin::QuizzesController < ApplicationController
  layout 'admin'
  def index
    @quizzes = Quiz.all
  end


  def update
    @quiz = Quiz.find(params[:id])
    @quiz.update(quiz_params)
    redirect_to admin_quiz_path(@quiz)
  end


  def edit
  end

  def show
    @quiz = Quiz.find(params[:id])
  end
  
  
  private
  def quiz_params
    params.require(:quiz).permit(:status)
  end
end
