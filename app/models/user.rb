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
  has_many :activities, dependent: :destroy
  has_one :activity, as: :subject, dependent: :destroy

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
    level_up_flag = 0
    while exp_point >= (le + 2)
      exp_point -= (le + 2)
      le += 1
      level_up_flag = 1
    end
    update(level: le, experience_point: exp_point)
    if level_up_flag == 1
      create_activities
    end
  end

  # ユーザーのお問い合わせフォームがあるかどうか
  def inquired?
    chat_room.present?
  end
  # 通知の未読の数
  def unread_activities
    activities.where(read: false)
  end
  # ユーザーのレベル通知を既読にする
  def all_read_leveled_up
    ua_level = unread_activities.where(action_type: "leveled_up")
    if ua_level.present?
      ua_level.update_all(read: true)
    end
  end

  private
  def create_activities
    Activity.create!(subject: self, content: level, user_id: id, action_type: :leveled_up)
  end
end
