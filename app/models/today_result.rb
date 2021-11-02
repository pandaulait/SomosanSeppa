# frozen_string_literal: true

class TodayResult < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  belongs_to :today_quiz

  def to_answer_array(number)
    a = answer.split[number]
    ActiveRecord::Type::Boolean.new.cast(a)
  end
end
