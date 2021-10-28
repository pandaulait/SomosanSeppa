class Quiz < ApplicationRecord
  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, presence: true, length: { in: 3..200 }

  belongs_to :user
  has_many :choices, dependent: :destroy
end
