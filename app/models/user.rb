class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name,     presence: true, length: { in: 3..200 }
  has_one_attached :profile_image
  has_many :selection_quizzes, dependent: :destroy
  has_many :results, dependent: :destroy
  has_many :today_results, dependent: :destroy
  has_one :chat_room, dependent: :destroy
  has_many :chats, dependent: :destroy

  # そのクイズを答えたことがあるか
  def answered?(quiz)
    results.where(quiz_id: quiz.id, quiz_type: quiz.class.to_s).present?
  end

  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

  # 今日の五問を解き終わったか
  def finish_today_quizzes?
    flag = true
    flag = false if today_status < 5
    flag
  end

  # 今日の五問の正解数
  def today_quiz_score
    score = 0
    @quizzes = TodayQuiz.where(content: Date.today)
    @quizzes.each do |q|
      result = q.today_results.find_by(user_id: id)
      score += 1 if result.content
    end
    score
  end
  # 経験値取得、レベルに応じてレベルアップ処理
  def get_exp(point)
    exp_point = experience_point
    exp_point += point
    le = level
    while exp_point >=( le + 2 )
      exp_point -= (le + 2)
      le += 1
    end
    update(level: le, experience_point: exp_point)
  end
  # ユーザーのお問い合わせフォームがあるかどうか
  def inquired?
    chat_room.present?
  end
end
