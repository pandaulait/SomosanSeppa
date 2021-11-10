class CreateChatRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_rooms do |t|
      t.references :user, foreign_key: true
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
