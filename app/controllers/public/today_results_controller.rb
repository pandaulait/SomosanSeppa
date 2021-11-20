class Public::TodayResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_finished_today_quiz, only: [:index]
  layout 'answer'
  def index
    @today_quizzes = TodayQuiz.where(content: Date.today)
    @today_quizzes = @today_quizzes.map do |tq|
      [tq, tq.quiz, tq.today_results.find_by(user_id: current_user.id), tq.get_entities]
    end
  end

  def create
    today_result = TodayResult.new(today_result_params)
    today_result.user_id = current_user.id
    quiz = today_result.quiz

    today_quiz = quiz.today_quizzes.find_by(content: Date.today)
    today_result.today_quiz_id = today_quiz.id

    case today_result.quiz_type
    # SelectionQuiz 解答作成
    when 'SelectionQuiz'
      answers = normalize(params[:today_result][:answer])
      if TodayResult.selection_quiz_save(answers, today_result)
        @today_result = today_quiz.today_results.find_by(user_id: current_user.id)
        status = current_user.today_status + 1
        current_user.update(today_status: status)
        today_quiz.update(challenger: today_quiz.challenger + 1)
        today_quiz.update(correct_answerer: today_quiz.correct_answerer + 1) if @today_result.content
        current_user.get_exp(5)
        redirect_to today_quizzes_path
      else
        redirect_to root_path
      end
    when 'DescriptiveQuiz'
      answer = params[:today_result][:answer]
      if TodayResult.descriptive_quiz_save(answer, today_result)
        @today_result = today_quiz.today_results.find_by(user_id: current_user.id)
        status = current_user.today_status + 1
        current_user.update(today_status: status)
        today_quiz.update(challenger: today_quiz.challenger + 1)
        today_quiz.update(correct_answerer: today_quiz.correct_answerer + 1) if @today_result.content
        current_user.get_exp(5)
        redirect_to today_quizzes_path
      else
        redirect_to root_path
      end
    end
    # @choices = @quiz.choices
    # i = 0
    # all_correct = true
    # correct_count = 0
    # @choices.each do |choice|
    #   if choice.is_answer == @answers[i]
    #     correct_count += 1
    #   else
    #     all_correct = false
    #   end
    #   i += 1
    # end
    # @today_result = TodayResult.new(user_id: current_user.id, quiz_id: @quiz.id, quiz_type: @quiz.class, today_quiz_id: today_quiz.id,
    #                                 content: all_correct, correct_count: correct_count, answer: @answers.join(' '))
  end

  private

  def today_result_params
    params.require(:today_result).permit(:quiz_id, :quiz_type)
  end

  # 解答の正規化
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

  # 今日、今日の五問に挑戦しているか
  def ensure_finished_today_quiz
    unless TodayResult.all.where('created_at >= ?', Date.today).where(user_id: current_user.id).present?
      current_user.update(today_status: 0)
    end
    return if current_user.finish_today_quizzes?

    redirect_to today_quizzes_path
  end
end
