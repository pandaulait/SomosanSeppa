class Public::TodayResultsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_finished_today_quiz, only: [:index]
  layout 'answer'
  def index
    @today_quizzes = TodayQuiz.where(content: Date.today)
  end


  def create
    @answers = normalize(params[:today_result][:answer])
    today_quiz = TodayQuiz.where(content: Date.today)[current_user.today_status]
    @quiz = today_quiz.quiz
    @today_result = TodayResult.new
    @choices = @quiz.choices

    i = 0
    all_correct = true
    correct_count = 0
    @choices.each do |choice|
      if choice.is_answer == @answers[i]
        correct_count += 1
      else
        all_correct = false
      end
      i+= 1
    end
    @today_result = TodayResult.new(user_id: current_user.id, quiz_id: @quiz.id, today_quiz_id: today_quiz.id, content: all_correct, correct_count: correct_count, answer: @answers.join(" "))

    if @today_result.save
      status = current_user.today_status + 1
      current_user.update(today_status: status)
      today_quiz.update(challenger: today_quiz.challenger+1)
      today_quiz.update(correct_answerer: today_quiz.correct_answerer+1) if all_correct
      redirect_to today_quizzes_path
    else
      redirect_to root_path
    end
  end

  private
  # 解答の正規化
  def normalize(array)
    flag = 0
    i = 0
    true_count =0
    while flag == 0
      if i <=  (array.count - 2)
        if array[i] == "0" && array[i+1] == "1"
          array.delete_at(i)
          true_count += 1
          array[i] = true
        else
          array[i] = false
        end
        i += 1
      else
        if array[i] == "0"
          array[i] = false
        end
        flag = 1
      end
    end
    array.push(true_count)
    return array
  end
  # 今日、今日の五問に挑戦しているか
  def ensure_finished_today_quiz
    unless TodayResult.all.where("created_at >= ?", Date.today).where(user_id: current_user.id).present?
      current_user.update(today_status: 0)
    end
    return if current_user.finish_today_quizzes?
    redirect_to today_quizzes_path
  end
end
