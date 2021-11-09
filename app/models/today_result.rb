class TodayResult < ApplicationRecord
  belongs_to :user
  belongs_to :selection_quiz
  belongs_to :today_quiz

  def to_answer_array(number)
    a = answer.split[number]
    ActiveRecord::Type::Boolean.new.cast(a)
  end
end
