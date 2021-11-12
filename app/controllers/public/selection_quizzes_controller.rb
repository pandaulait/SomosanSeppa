class Public::SelectionQuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: %i[edit update]
  before_action :ensure_normal_admin, only: [:update]
  before_action :ensure_today_quiz, only: %i[edit update]

  def show
    @quiz = SelectionQuiz.find(params[:id])
    @choices = @quiz.choices
    @result = @quiz.results.new
  end

  def index
    @quizzes = SelectionQuiz.all.published.order(created_at: :desc)
    @quizzes = @quizzes.authenticated if params[:sort] == '0'
    @quizzes = @quizzes.unauthenticated if params[:sort] == '1'
  end

  def new
    @quiz = SelectionQuiz.new
  end

  def create
    @quiz = SelectionQuiz.new(selection_quiz_params)
    @quiz.user_id = current_user.id
    # クイズを保存したのち、選択肢も保存し、エラーが発生した場合ロールバック
    SelectionQuiz.transaction(joinable: false, requires_new: true) do
      if @quiz.save
        @choices = params[:selection_quiz][:choices]
        @is_answers = params[:choice][:is_answer]
        if Choice.choice_create(@choices, @quiz.id, @is_answers)
          if current_user.admin?
            redirect_to admin_selection_quiz_path(@quiz)
          else
            redirect_to selection_quiz_path(@quiz)
          end
        else
          flash.now[:alert] = '更新に失敗しました。正解の選択肢にチェックはついていますか。'
          raise ActiveRecord::Rollback
        end
      end
    end
    # エラー表示はajaxでcreate.js.erbへ
  end

  def edit
    @quiz = SelectionQuiz.find(params[:id])
    @choices = @quiz.choices
  end

  def update
    @quiz = SelectionQuiz.find(params[:id])
    @choices = @quiz.choices
    # クイズを更新したのち、選択肢も更新し、エラーが発生した場合ロールバック
    @quiz.status = 'unauthenticated' if @quiz.status == 'authenticated'
    if @quiz.update(selection_quiz_params)
      choices = params[:selection_quiz][:choices]
      @is_answers = params[:selection_quiz][:choice][:is_answer]
      @choice_ids = params[:selection_quiz][:choice_id]
      if Choice.choice_update(choices, @quiz.id, @is_answers, @choice_ids)
        if current_user.admin?
          redirect_to admin_selection_quiz_path(@quiz)
        else
          redirect_to selection_quiz_path(@quiz)
        end
      else
        flash.now[:alert] = '更新に失敗しました。'
      end
    end
  end

  def random_select; end

  def seppa
    @quiz = SelectionQuiz.randomly_selected(current_user)
  end

  private

  def selection_quiz_params
    params.require(:selection_quiz).permit(:content, :explanation)
  end

  # current_userとクイズの作者が一致しているかどうか
  def ensure_correct_user
    user = SelectionQuiz.find(params[:id]).user
    return if user == current_user || current_user.admin?

    flash[:alert] = '他人のクイズは編集できません。'
    redirect_to root_path
  end

  # ゲスト管理者でないか
  def ensure_normal_admin
    return if current_user.email != 'admin@example.com'

    flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
    redirect_to selection_quiz_path(SelectionQuiz.find(params[:id]))
  end

  def ensure_today_quiz
    return unless SelectionQuiz.find(params[:id]).today_quizzes.find_by(content: Date.today).present?
    return if current_user.email == 'pandaulait73@gmail.com'

    flash[:alert] = '今日の5問に選ばれているため、編集ができません。また後日編集するか、新規作成を行ってください。'
    redirect_to selection_quiz_path(SelectionQuiz.find(params[:id]))
  end
  # def quiz_params
  #   params.require(:quiz).permit(:choice, :explanation)
  # end
end
