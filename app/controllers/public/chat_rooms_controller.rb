class Public::ChatRoomsController < ApplicationController
  def index
    @chat_room = ChatRoom.find_or_create_by(user_id: current_user.id) 
    @chats = @chat_room.chats
    @chat = @chat_room.chats.new

  end
  
  def create
  end
end
