class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  def create
    @chat_room = current_user.chat_room
    @chat = @chat_room.chats.new(chats_params)
    @chat.admin = false
    @chat.save
    redirect_to chat_rooms_path(anchor: "chat_room-bottom")
  end

  def chats_params
    params.require(:chat).permit(:content, :user_id, :chat_room_id)
  end
end
