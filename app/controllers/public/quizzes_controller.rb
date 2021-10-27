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
    Quiz.transaction(joinable: false, requires_new: true) do
      @choices = params[:quiz][:choices]
      @is_answers = params[:choice][:is_answer]
      if @quiz.save
        @choices = params[:quiz][:choices]
        
        if Choice.choice_create(@choices, @quiz.id, @is_answers)
          redirect_to quiz_path(@quiz)
        else
          raise ActiveRecord::Rollback
          byebug
          render :new
        end
      else
        # raise ActiveRecord::Rollback
        render :new
      end
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
  # def quiz_params
  #   params.require(:quiz).permit(:choice, :explanation)
  # end
end
