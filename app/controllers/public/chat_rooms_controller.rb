class Public::ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chat_room = ChatRoom.find_or_create_by(user_id: current_user.id)
    @chats = @chat_room.chats
    @chat = Chat.new
  end

  def create; end
end
