class Public::ResultsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @results = @user.results.order(id: 'DESC')
  end

  def show
    @quiz = Quiz.find(params[:quiz_id])
    @result = Result.find(params[:id])
    render layout: 'answer'
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
    # 回答と解答からスコアを保存
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
    @result.answer = @answers.join(' ')
    if @result.save
      redirect_to quiz_result_path(@quiz, @result)
    else
      render('quiz/show')
    end
  end

  private

  # is_answersの正気化
  def normalize(array)
    flag = 0
    i = 0
    true_count = 0
    while flag == 0
      if i <=  (array.count - 2)
        if array[i] == '0' && array[i + 1] == '1'
          array.delete_at(i)
          true_count += 1
          array[i] = true
        else
          array[i] = false
        end
        i += 1
      else
        array[i] = false if array[i] == '0'
        flag = 1
      end
    end
    array.push(true_count)
    array
  end
end
