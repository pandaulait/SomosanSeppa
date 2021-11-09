class ChangeQuizzesToSelectionQuizzes < ActiveRecord::Migration[5.2]
  def change
    rename_table :quizzes, :selection_quizzes
  end
end
