class Public::ChatsController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat][:chat_room_id])
    @chat = @chat_room.chats.new(chats_params)
    @chat.admin = false
    @chat.save
    redirect_to chat_rooms_path
  end

  def chats_params
    params.require(:chat).permit(:content, :user_id, :chat_room_id)
  end
end
