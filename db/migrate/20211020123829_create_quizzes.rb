class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.text :content
      t.text :explanation
      t.integer :status

      t.timestamps
    end
  end
end
