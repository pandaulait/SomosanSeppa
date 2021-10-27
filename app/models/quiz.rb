class Quiz < ApplicationRecord
  validates :content, presence: true, length: { in: 10..200 }
  validates :explanation, presence: true, length: { minimum: 10 , maximum: 500}

  belongs_to :user
  has_many :choices, dependent: :destroy
end
