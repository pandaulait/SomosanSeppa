class TodayQuiz < ApplicationRecord
  belongs_to :quiz, polymorphic: true
  has_many :today_results, dependent: :destroy
  validates :content, presence: true
  # 今日の五問選ぶメソッド
  def self.five_create
    len = 10
    s_quiz = SelectionQuiz.all.authenticated
    d_quiz = DescriptiveQuiz.all.authenticated
    quizzes = s_quiz + d_quiz
    len = quizzes.size if quizzes.size < len
    quizzes = quizzes.map { |q| [q, q.solved_times] }
    sample_5 =  quizzes.sort { |a, b| a[1] <=> b[1] }[0..len].sample(5)
    all_valid = true
    TodayQuiz.transaction(joinable: false, requires_new: true) do
      sample_5.each do |sample|
        today_quiz = TodayQuiz.new(content: Date.today, quiz_id: sample[0].id, quiz_type: sample[0].class)
        all_valid &= today_quiz.save
      end
      raise ActiveRecord::Rollback unless all_valid
    end
    all_valid
  end

  def self.five_created?
    TodayQuiz.where(content: Date.today).present?
  end
end
