class Public::QuizzesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :ensure_normal_admin, only: [:update]

  def show
    @quiz = Quiz.find(params[:id])
    @choices = @quiz.choices
    @result = Result.new
  end


  def index
    @quizzes = Quiz.all.published.order(created_at: :desc)
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    @quiz.user_id = current_user.id
    Quiz.transaction(joinable: false, requires_new: true) do
      if @quiz.save
        @choices = params[:quiz][:choices]
        @is_answers = params[:choice][:is_answer]
        if Choice.choice_create(@choices, @quiz.id, @is_answers)
          if current_user.admin?
            redirect_to admin_quiz_path(@quiz)
          else
            redirect_to quiz_path(@quiz)
          end
        else
          flash.now[:alert] ="更新に失敗しました。正解の選択肢にチェックをおつけください。"
          raise ActiveRecord::Rollback
        end
        # render :new
      end
    end
  end

  def edit
    @quiz = Quiz.find(params[:id])
    @choices = @quiz.choices
  end

  def update
    @quiz = Quiz.find(params[:id])
    @choices = @quiz.choices
    if @quiz.update(quiz_params)
      choices = params[:quiz][:choices]
      @is_answers = params[:quiz][:choice][:is_answer]
      @choice_ids = params[:quiz][:choice_id]
      # byebug
      if Choice.choice_update(choices, @quiz.id, @is_answers, @choice_ids)
        if current_user.admin?
          redirect_to admin_quiz_path(@quiz)
        else
          redirect_to quiz_path(@quiz)
        end
      else
        if @alert.present?
          flash[:alert] = @alert
        end
        flash.now[:alert] ="更新に失敗しました。"
        render :edit
      end
    else
      render :edit
    end
  end


  def random_select
  end

  def seppa
    @quiz = Quiz.randomly_selected(current_user)
  end

  private

  def quiz_params
    params.require(:quiz).permit(:content, :explanation)
  end
  def ensure_correct_user
    user = Quiz.find(params[:id]).user
    return if (user == current_user || current_user.admin?)

    flash[:alert] = '他人のコラムは編集できません。'
    redirect_to root_path
  end
  def ensure_normal_admin
    return if current_user.email != 'admin@example.com'

    flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
    redirect_to request.referer
  end
  # def quiz_params
  #   params.require(:quiz).permit(:choice, :explanation)
  # end
end
