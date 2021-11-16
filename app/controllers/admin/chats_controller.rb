class Admin::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:create]

  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @chat = @chat_room.chats.new(chats_params)
    @chat.admin = true
    @chat.save
    redirect_to admin_chat_room_path(@chat_room, anchor: "chat_room-bottom")
  end

  private

  def chats_params
    params.require(:chat).permit(:content, :user_id)
  end

  # 管理者ユーザー判定
  def admin_user
    return if current_user.admin?

    flash[:alert] = '管理者権限がありません。'
    redirect_to root_path
  end

  # ゲスト管理者判定
  def ensure_normal_admin
    return if current_user.email != 'admin@example.com'

    flash[:alert] = 'ゲスト管理者権限では、お問い合わせ対応はできません。'
    redirect_to root_path
  end
end
