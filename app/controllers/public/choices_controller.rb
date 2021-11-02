class Public::ChoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user

  def destroy
    choice = Choice.find(params[:id])
    if Quiz.find(params[:quiz_id]).choices.count > 2
      choice.destroy
    else
      flash[:alert] = "選択肢は2つ以上にしてください"
    end
    redirect_to edit_quiz_path(Quiz.find(params[:quiz_id]))
  end

  def new
    @quiz = Quiz.find(params[:quiz_id])
    @choice = @quiz.choices.new
  end

  def create
    @quiz = Quiz.find(params[:quiz_id])
    @choice = Choice.new(choice_params)
    # @choice.quiz_id = @quiz.id
    if @choice.save
      redirect_to edit_quiz_path(@quiz)
    end
  end


  private
  def choice_params
    params.require(:choice).permit(:quiz_id, :content, :is_answer)
  end
  # current_userとクイズの作者が一致しているかどうか
  def ensure_correct_user
    user = Quiz.find(params[:quiz_id]).user
    return if (user == current_user || current_user.admin?)

    flash[:alert] = '他人のクイズは編集できません。'
    redirect_to root_path
  end
end
