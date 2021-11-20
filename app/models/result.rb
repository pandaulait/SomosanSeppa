class Result < ApplicationRecord
  validates :user_id, presence: true
  validates :quiz_id, presence: true
  validates :quiz_type, presence: true
  validates :correct_count, presence: true, if: proc { |result| result.quiz_type == 'SelectionQuiz' }
  validates :content, inclusion: { in: [true, false] }
  validates :answer, presence: true, length: { maximum: 200 }, if: proc { |result| result.quiz_type == 'DescriptiveQuiz' }
  belongs_to :user
  belongs_to :quiz, polymorphic: true

  # 回答の配列のtrueをstringからbooleanへ
  def to_answer_array(number)
    a = answer.split[number]
    ActiveRecord::Type::Boolean.new.cast(a)
  end

  # SelectionQuiz_result　の作成
  def self.selection_quiz_save(answers, result)
    @quiz = result.quiz
    @choices = @quiz.choices
    i = 0
    all_correct = true
    correct_count = 0
    # 回答と解答からスコアを保存
    @choices.each do |choice|
      if choice.is_answer == answers[i]
        correct_count += 1
      else
        all_correct &= false
      end
      i += 1
    end
    result.content = all_correct
    result.correct_count = correct_count
    result.answer = answers.join(' ')
    result.save
  end

  # DescriptiveQuiz_result　の作成
  def self.descriptive_quiz_save(answer, result)
    result.answer = answer
    result.content = true
    result.correct_count = 0
    result.save
  end
end
