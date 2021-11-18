class CreateDescriptiveQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :descriptive_quizzes do |t|
      t.references :user
      t.text :content, null: false
      t.text :explanation, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
