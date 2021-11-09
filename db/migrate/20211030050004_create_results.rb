class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :user, foreign_key: true
      t.references :quiz, polymorphic: true
      t.integer :correct_count, null: false
      t.string :answer, null: false
      t.boolean :content, null: false

      t.timestamps
    end
  end
end
