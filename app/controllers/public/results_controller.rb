class Public::ResultsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = User.find(params[:user_id])
    @results = @user.results.order(id: 'DESC')
  end

  def show
    @result = Result.find(params[:id])
    @quiz = @result.quiz
    if @result.quiz_type == "DescriptiveQuiz"
      @entities = @quiz.get_entities
    end

    render layout: 'answer'
  end

  def create
    @result = Result.new(result_params)
    @result.user_id = current_user.id
    case @result.quiz_type
    # SelectionQuiz 解答作成
    when 'SelectionQuiz'
      @answers = normalize(params[:result][:answer])
      if Result.selection_quiz_save(@answers, @result)
        result = @result.quiz.results.where(user_id: current_user.id).last
        current_user.get_exp(10) # 経験値の取得
        redirect_to selection_quiz_result_path(@result.quiz, result)
      end
    # DescriptiveQuiz 解答作成
    when 'DescriptiveQuiz'
      @answer = params[:result][:answer]
      if Result.descriptive_quiz_save(@answer, @result)
        result = @result.quiz.results.where(user_id: current_user.id).last
        current_user.get_exp(10) # 経験値の取得
        redirect_to descriptive_quiz_result_path(@result.quiz, result)
      end
    end
  end

  private

  def result_params
    params.require(:result).permit(:quiz_id, :quiz_type)
  end

  # is_answersの正規化(チェックボックスを配列で取得した際に余計に送られる0を消す。)
  # 解答[0, 1] -> params[0, 0, 1] -> normalize後[0, 1]
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
