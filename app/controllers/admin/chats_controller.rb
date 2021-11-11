class Admin::ChatsController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @chat = @chat_room.chats.new(chats_params)
    @chat.admin = true
    @chat.save
    redirect_to admin_chat_room_path(@chat_room)
  end

  def chats_params
    params.require(:chat).permit(:content, :user_id)
  end
end
