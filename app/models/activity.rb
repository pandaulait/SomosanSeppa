class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  enum action_type: { chatted_by_admin: 0, chatted_by_user: 1 }
end
