class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.references :user, foreign_key: true
      t.references :chat_room, foreign_key: true
      t.string :content, null: false
      t.boolean :admin, null: false, default: 0

      t.timestamps
    end
  end
end
