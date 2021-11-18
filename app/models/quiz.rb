class Quiz < ApplicationRecord
  def self.poyong
    'poyong'
  end

  def self.randomly_selected(user)
    len = 5
    s_quiz = SelectionQuiz.all.published
    d_quiz = DescriptiveQuiz.all.published
    quizzes = s_quiz + d_quiz
    len = quizzes.size if quizzes.size < len
    quizzes = quizzes.map { |q| [q, q.solved_times_by(user)] }
    quizzes.sort { |a, b| a[1] <=> b[1] }[0..len].sample[0]
  end
end
