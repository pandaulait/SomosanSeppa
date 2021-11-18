class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.references :user
      t.text :content, null: false
      t.text :explanation, null: false, default: ''
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
