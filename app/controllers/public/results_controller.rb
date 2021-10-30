class Public::ResultsController < ApplicationController
  def index
  end

  def create
    @answers = normalize(params[:result][:answer])
    @quiz = Quiz.find(params[:quiz_id])
    @result = Result.new
    @result.user_id = current_user.id
    @result.quiz_id = @quiz.id
    @choices = @quiz.choices
    i = 0
    all_correct = true
    correct_count = 0
    @choices.each do |choice|
      if choice.is_answer == @answers[i]
        correct_count += 1
      else
        all_correct &= false
      end
      i += 1
    end
    @result.content = all_correct
    @result.correct_count = correct_count
    byebug
    if @result.save
      redirect_to root_path
    else
      redirect_to quiz_path(@quiz)
    end
  end

  private
  # is_answersの正気化
  def normalize(array)
    flag = 0
    i = 0
    while flag == 0
      if i <=  (array.count - 2)
        if array[i] == "0" && array[i+1] == "1"
          array.delete_at(i)
        end
        i += 1
      else
        flag = 1
      end
    end
    return array
  end

end

