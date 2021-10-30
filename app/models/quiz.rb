class Quiz < ApplicationRecord
  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, presence: true, length: { in: 3..200 }

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :results, dependent: :destroy
  
  # クイズが解かれた回数
  def solved_times
    results.count
  end
end
