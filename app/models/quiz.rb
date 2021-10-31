class Quiz < ApplicationRecord
  enum status: { unauthenticated: 0, authenticated: 1, unpublished: 2 }

  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, presence: true, length: { in: 3..200 }

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :results, dependent: :destroy

  # クイズが解かれた回数
  def solved_times
    results.count
  end

  def solved_times_by(user)
    results.where(user_id: user.id).count
  end
  # ユーザーの最近解いてないクイズを1問用意する
  def self.randomly_selected(user)
    len = 5
    if Quiz.all.size < len
      len = Quiz.all.size
    end
    quizzes_number = Quiz.all.map.with_index{|q,i| [i+1, q.solved_times_by(user)]}
    quiz_number =  quizzes_number.sort {|a,b| a[1] <=> b[1]}[0.. len].sample[0]
    find(quiz_number)
  end
  # 有効={未認証, 認証済み}スコープ
  scope :published, -> { where(status: 0..1) }
end
