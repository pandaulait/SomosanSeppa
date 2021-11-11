class Admin::ChatRoomsController < ApplicationController
  def index
    #ユーザーとのお問い合わせ一覧
    @users = User.all

  end

  def show
    # お問い合わせページ
    @chat_room = ChatRoom.find(params[:id])
    @chats = @chat_room.chats
    @chat = Chat.new
  end
end
