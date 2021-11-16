class Activity < ApplicationRecord
  validates :action_type, presence: true
  validates :content,     presence: true
  enum action_type: { chatted_by_admin: 0, chatted_by_user: 1 ,leveled_up: 2}

  belongs_to :subject, polymorphic: true
  belongs_to :user
end
