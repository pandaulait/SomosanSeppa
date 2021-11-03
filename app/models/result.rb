class Result < ApplicationRecord
  validates :user_id, presence: true
  validates :quiz_id, presence: true
  validates :correct_count, presence: true
  validates :content, inclusion: { in: [true, false] }
  validates :answer, presence: true
  belongs_to :user
  belongs_to :quiz

  # 回答の配列のtrueをstringからbooleanへ
  def to_answer_array(number)
    a = answer.split[number]
    ActiveRecord::Type::Boolean.new.cast(a)
  end
end
