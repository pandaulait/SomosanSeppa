class CreateTodayResults < ActiveRecord::Migration[5.2]
  def change
    create_table :today_results do |t|
      t.references :user, foreign_key: true, null: false
      t.references :selection_quiz, foreign_key: true, null: false
      t.references :today_quiz, foreign_key: true, null: false
      t.integer :correct_count, null: false
      t.string :answer, null: false
      t.boolean :content, null: false

      t.timestamps
    end
  end
end
