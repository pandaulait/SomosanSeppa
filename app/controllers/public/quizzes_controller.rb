class Public::QuizzesController < ApplicationController
  def show
    @quiz = Quiz.find(params[:id])
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    if @quiz.save
      redirect_to quiz_path(@quiz)
    else
      render :new
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
  end
  
  def update
    @quiz = Quiz.find(params[:id])
    if @quiz.update(quiz_params)
      redirect_to quiz_path(@quiz)
    else
      render :edit
    end
    
  end

  def index
    @quizzes = Quiz.all
  end


  private

  def quiz_params
    params.require(:quiz).permit(:content, :explanation)
  end
end
