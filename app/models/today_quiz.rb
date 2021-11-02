class TodayQuiz < ApplicationRecord
  belongs_to :quiz
  has_many :today_results
  # 今日の五問選ぶメソッド
  def self.five_create
    len = 10
    if Quiz.all.authenticated.size < len
      len = Quiz.all.authenticated.size
    end
    quiz_numbers = Quiz.all.authenticated.map{|q| [q.id, q.solved_times]}
    sample_5 =  quiz_numbers.sort {|a,b| a[1] <=> b[1]}[0.. len].sample(5)
    all_valid = true
    TodayQuiz.transaction(joinable: false, requires_new: true) do
      sample_5.each do |sample|
        today_quiz = TodayQuiz.new(content: Date.today, quiz_id: sample[0])
        all_valid &= today_quiz.save
      end
      unless all_valid
        raise ActiveRecord::Rollback
      end
    end
    all_valid
  end

  def self.five_created?
    flag = TodayQuiz.where(content: Date.today).present?
    flag
  end
end
