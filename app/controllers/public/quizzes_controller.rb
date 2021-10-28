class Public::QuizzesController < ApplicationController
  def show
    @quiz = Quiz.find(params[:id])
    @choices = @quiz.choices
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    Quiz.transaction(joinable: false, requires_new: true) do
      if @quiz.save
        @choices = params[:quiz][:choices]
        @is_answers = params[:choice][:is_answer]
        if Choice.choice_create(@choices, @quiz.id, @is_answers)
          redirect_to quiz_path(@quiz)
        else
          raise ActiveRecord::Rollback
          render :new
        end
      else
        render :new
      end
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @choices = @quiz.choices
  end

  def update
    @quiz = Quiz.find(params[:id])
    @choices = @quiz.choices
    if @quiz.update(quiz_params)
      choices = params[:quiz][:choices]
      @is_answers = params[:quiz][:choice][:is_answer]
      @choice_ids = params[:quiz][:choice_id]
      # byebug
      if Choice.choice_update(choices, @quiz.id, @is_answers, @choice_ids)
        redirect_to quiz_path(@quiz)
      else
        render :edit
      end
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
  # def quiz_params
  #   params.require(:quiz).permit(:choice, :explanation)
  # end
end
