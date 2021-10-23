class Quiz < ApplicationRecord
  belongs_to :user
  has_many :quizzes, dependent: :destroy
  accepts_nested_attributes_for :quizzes, allow_destroy: true
end
