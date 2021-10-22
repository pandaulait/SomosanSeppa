class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.integer :user_id
      t.text :content
      t.text :explanation
      t.integer :status

      t.timestamps
    end
  end
end
