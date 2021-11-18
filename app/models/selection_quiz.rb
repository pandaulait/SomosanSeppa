class SelectionQuiz < ApplicationRecord
  enum status: { unauthenticated: 0, authenticated: 1, unpublished: 2 }
  has_one_attached :image
  # validate :image_type

  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, presence: true, length: { in: 3..500 }

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :results, as: :quiz, dependent: :destroy
  has_many :today_quizzes, as: :quiz, dependent: :destroy
  has_many :today_results, as: :quiz, dependent: :destroy
  # 有効={未認証, 認証済み}スコープ
  scope :published, -> { where(status: 0..1) }

  # クイズが解かれた回数
  def solved_times
    results.count + today_results.count
  end

  # クイズがユーザーに解かれた回数
  def solved_times_by(user)
    results.where(user_id: user.id).count today_results.where(user_id: user.id).count
  end
end
