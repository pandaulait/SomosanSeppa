class Chat < ApplicationRecord
  validates :content, presence: true
  belongs_to :user
  belongs_to :chat_room
  has_one :activity, as: :subject, dependent: :destroy

  # チャット送信時に通知レコードを作成
  # 管理側からか、ユーザーからかで場合分け
  after_create_commit :create_activities

  # private

  def create_activities
    if admin == true
      Activity.create!(subject: self, content: user.name, user: chat_room.user, action_type: :chatted_by_admin)
    else
      user = User.find_by(email: ENV['ADMIN_EMAIL'])
      Activity.create!(subject: self, content: chat_room.user.name, user: user, action_type: :chatted_by_user)
    end
  end
end
