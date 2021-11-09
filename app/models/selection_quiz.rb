class SelectionQuiz < ApplicationRecord
  enum status: { unauthenticated: 0, authenticated: 1, unpublished: 2 }

  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, presence: true, length: { in: 3..500 }

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :results, as: :quiz, dependent: :destroy
  has_many :today_quizzes, dependent: :destroy

  # クイズが解かれた回数
  def solved_times
    results.count
  end

  # クイズがユーザーに解かれた回数
  def solved_times_by(user)
    results.where(user_id: user.id).count
  end

  # ユーザーの最近解いてないクイズを1問用意する
  def self.randomly_selected(user)
    len = 5
    len = SelectionQuiz.all.published.size if SelectionQuiz.all.published.size < len
    quizzes_number = SelectionQuiz.all.published.map.with_index { |q, _i| [q.id, q.solved_times_by(user)] }
    quiz_number =  quizzes_number.sort { |a, b| a[1] <=> b[1] }[0..len].sample[0]
    find(quiz_number)
  end
  # 有効={未認証, 認証済み}スコープ
  scope :published, -> { where(status: 0..1) }
end
