class DescriptiveQuiz < ApplicationRecord
  enum status: { unauthenticated: 0, authenticated: 1, unpublished: 2 }
  has_one_attached :image

  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, length: { in: 0..500 }

  belongs_to :user
  has_many :results, as: :quiz, dependent: :destroy
  has_many :today_quizzes, as: :quiz, dependent: :destroy
  has_many :today_results, as: :quiz, dependent: :destroy
end
