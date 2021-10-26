class Quiz < ApplicationRecord
  validates :content, presence: true, length: { minimum: 10 , maximam: 200}
  validates :explanation, presence: true, length: { minimum: 10 , maximam: 500}

  belongs_to :user
  has_many :choices, dependent: :destroy

end
