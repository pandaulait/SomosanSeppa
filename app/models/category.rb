# frozen_string_literal: true

class Category < ApplicationRecord
  validates :content, presence: true, uniqueness: true, length: { minimum: 2, maximum: 20 }
end
