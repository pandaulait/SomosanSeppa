class Admin::ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_user
  before_action :ensure_normal_admin, only: [:show]
  layout 'admin'
  
  def index
    # ユーザーとのお問い合わせ一覧
    @users = User.all
  end
  
  def show
    # お問い合わせページ
    @chat_room = ChatRoom.find(params[:id])
    @chats = @chat_room.chats
    @chat = Chat.new
    @all_read_number = @chat_room.all_read_chatted_by_user
  end

  private

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
