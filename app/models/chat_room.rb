class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chats
  has_many :activities, through: :chats
  # ユーザーがお問い合わせチャットを閲覧した際に、通知に既読が着く
  def all_read_chatted_by_admin
    unread_id = -1
    unread_activities = activities.where(read: false, action_type: 'chatted_by_admin')
    if unread_activities.present?
      unread_id = unread_activities.first.subject.id
      unread_activities.update_all(read: true)
    end
    unread_id
  end

  # 管理者がお問い合わせチャットを閲覧した際に通知に既読が着く
  def all_read_chatted_by_user
    unread_id = -1
    unread_activities = activities.where(read: false, action_type: 'chatted_by_user')
    if unread_activities.present?
      unread_id = unread_activities.first.subject.id
      unread_activities.update_all(read: true)
    end
    unread_id
  end
end
