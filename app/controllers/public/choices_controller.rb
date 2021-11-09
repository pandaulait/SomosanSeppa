class Public::ChoicesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user

  def destroy
    choice = Choice.find(params[:id])
    if SelectionQuiz.find(params[:selection_quiz_id]).choices.count > 2
      choice.destroy
    else
      flash[:alert] = '選択肢は2つ以上にしてください'
    end
    redirect_to edit_selection_quiz_path(SelectionQuiz.find(params[:selection_quiz_id]))
  end

  def new
    @quiz = SelectionQuiz.find(params[:selection_quiz_id])
    @choice = @quiz.choices.new
  end

  def create
    @quiz = SelectionQuiz.find(params[:selection_quiz_id])
    @choice = Choice.new(choice_params)
    # @choice.quiz_id = @quiz.id
    redirect_to edit_selection_quiz_path(@quiz) if @choice.save
  end

  private

  def choice_params
    params.require(:choice).permit(:selection_quiz_id, :content, :is_answer)
  end

  # current_userとクイズの作者が一致しているかどうか
  def ensure_correct_user
    user = SelectionQuiz.find(params[:selection_quiz_id]).user
    return if user == current_user || current_user.admin?

    flash[:alert] = '他人のクイズは編集できません。'
    redirect_to root_path
  end
end
