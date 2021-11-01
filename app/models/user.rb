class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name,     presence: true, length: { in: 3..200 }
  has_one_attached :profile_image
  has_many :quizzes, dependent: :destroy
  has_many :results, dependent: :destroy



  # そのクイズを答えたことがあるか
  def answered?(quiz)
    results.where(quiz_id: quiz.id).present?
  end
  # ゲストログイン
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
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

end
