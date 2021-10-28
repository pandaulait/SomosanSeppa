class Public::ChoicesController < ApplicationController
  def destroy
    choice = Choice.find(params[:id])
    choice.destroy
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
    
    # byebug
  end
  
  
  private
  def choice_params
    params.require(:choice).permit(:quiz_id, :content, :is_answer)
  end
end
