# frozen_string_literal: true

module Public
  class QuizzesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, only: %i[edit update]
    before_action :ensure_normal_admin, only: [:update]
    before_action :ensure_today_quiz, only: %i[edit update]

    def show
      @quiz = Quiz.find(params[:id])
      @choices = @quiz.choices
      @result = Result.new
    end

    def index
      @quizzes = Quiz.all.published.order(created_at: :desc)
      @quizzes = @quizzes.authenticated if params[:sort] == '0'
      @quizzes = @quizzes.unauthenticated if params[:sort] == '1'
    end

    def new
      @quiz = Quiz.new
    end

    def create
      @quiz = Quiz.new(quiz_params)
      @quiz.user_id = current_user.id
      # クイズを保存したのち、選択肢も保存し、エラーが発生した場合ロールバック
      Quiz.transaction(joinable: false, requires_new: true) do
        if @quiz.save
          if Choice.choice_create(params[:quiz][:choices], @quiz.id, params[:choice][:is_answer])
            if current_user.admin?
              redirect_to admin_quiz_path(@quiz)
            else
              redirect_to quiz_path(@quiz)
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
      @quiz = Quiz.find(params[:id])
      @choices = @quiz.choices
    end

    def update
      @quiz = Quiz.find(params[:id])
      @choices = @quiz.choices
      # クイズを更新したのち、選択肢も更新し、エラーが発生した場合ロールバック
      @quiz.status = 'unauthenticated' if @quiz.status == 'authenticated'
      return unless @quiz.update(quiz_params)

      if Choice.choice_update(params[:quiz][:choices], @quiz.id, params[:quiz][:choice][:is_answer],
                              params[:quiz][:choice_id])
        if current_user.admin?
          redirect_to admin_quiz_path(@quiz)
        else
          redirect_to quiz_path(@quiz)
        end
      else
        flash.now[:alert] = '更新に失敗しました。正解の選択肢にチェックはついていますか。'
      end
    end

    def random_select; end

    def seppa
      @quiz = Quiz.randomly_selected(current_user)
    end

    private

    def quiz_params
      params.require(:quiz).permit(:content, :explanation)
    end

    # current_userとクイズの作者が一致しているかどうか
    def ensure_correct_user
      user = Quiz.find(params[:id]).user
      return if user == current_user || current_user.admin?

      flash[:alert] = '他人のクイズは編集できません。'
      redirect_to root_path
    end

    # ゲスト管理者でないか
    def ensure_normal_admin
      return if current_user.email != 'admin@example.com'

      flash[:alert] = 'ゲスト管理者権限では、ステータスの変更はできません。'
      redirect_to quiz_path(Quiz.find(params[:id]))
    end

    def ensure_today_quiz
      return unless Quiz.find(params[:id]).today_quizzes.find_by(content: Date.today).present?

      flash[:alert] = '今日の5問に選ばれているため、編集ができません。また後日編集するか、新規作成を行ってください。'
      redirect_to quiz_path(Quiz.find(params[:id]))
    end
    # def quiz_params
    #   params.require(:quiz).permit(:choice, :explanation)
    # end
  end
end
