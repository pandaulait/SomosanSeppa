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
    quizzes = quizzes.map { |q| [q.id, q.solved_times_by(user), q.class.to_s] }
    selected_quiz = quizzes.sort { |a, b| a[1] <=> b[1] }[0..len].sample
    case selected_quiz[2]
    when 'SelectionQuiz'
      quiz = SelectionQuiz.find(selected_quiz[0])
    when 'DescriptiveQuiz'
      quiz = DescriptiveQuiz.find(selected_quiz[0])
    end
    quiz
  end
end
