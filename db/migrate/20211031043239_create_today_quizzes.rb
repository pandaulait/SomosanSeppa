# frozen_string_literal: true

class CreateTodayQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :today_quizzes do |t|
      t.date :content, null: false
      t.references :quiz, foreign_key: true, null: false
      t.integer :challenger, null: false, default: 0
      t.integer :correct_answerer, null: false, default: 0

      t.timestamps
    end
  end
end
