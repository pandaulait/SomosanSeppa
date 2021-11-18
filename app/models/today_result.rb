class TodayResult < ApplicationRecord
  belongs_to :user
  belongs_to :quiz, polymorphic: true
  belongs_to :today_quiz

  validates :user_id, presence: true
  validates :today_quiz_id, presence: true
  validates :quiz_id, presence: true
  validates :quiz_type, presence: true
  validates :correct_count, presence: true, if: proc { |result| result.quiz_type == 'SelectionQuiz' }
  validates :content, inclusion: { in: [true, false] }
  validates :answer, presence: true
  # stringで保存したtrueをboolean型に
  def to_answer_array(number)
    a = answer.split[number]
    ActiveRecord::Type::Boolean.new.cast(a)
  end

  # SelectionQuiz_today_result　の作成
  def self.selection_quiz_save(answers, today_result)
    quiz = today_result.quiz
    choices = quiz.choices
    i = 0
    all_correct = true
    correct_count = 0
    choices.each do |choice|
      if choice.is_answer == answers[i]
        correct_count += 1
      else
        all_correct = false
      end
      i += 1
    end
    today_result.content = all_correct
    today_result.correct_count = correct_count
    today_result.answer = answers.join(' ')
    today_result.save
  end

  # DescriptiveQuiz_result　の作成
  def self.descriptive_quiz_save(answer, today_result)
    today_result.answer = answer
    today_result.content = true
    today_result.correct_count = 0
    today_result.save
  end
end
