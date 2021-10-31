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
  # 有効={未認証, 認証済み}スコープ
  scope :published, -> { where(status: 0..1) }
end
