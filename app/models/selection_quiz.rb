class SelectionQuiz < ApplicationRecord
  enum status: { unauthenticated: 0, authenticated: 1, unpublished: 2 }
  has_one_attached :image
  # validate :image_type

  validates :content,     presence: true, length: { in: 3..200 }
  validates :explanation, presence: true, length: { in: 3..500 }

  belongs_to :user
  has_many :choices, dependent: :destroy
  has_many :results, as: :quiz, dependent: :destroy
  has_many :today_quizzes, as: :quiz, dependent: :destroy
  has_many :today_results, as: :quiz, dependent: :destroy
  # 有効={未認証, 認証済み}スコープ
  scope :published, -> { where(status: 0..1) }

  # クイズが解かれた回数
  def solved_times
    results.count + today_results.count
  end

  # クイズがユーザーに解かれた回数
  def solved_times_by(user)
    results.where(user_id: user.id).count today_results.where(user_id: user.id).count
  end

  # # ユーザーの最近解いてないクイズを1問用意する
  # def self.randomly_selected(user)
  #   len = 5
  #   len = SelectionQuiz.all.published.size if SelectionQuiz.all.published.size < len
  #   quizzes_number = SelectionQuiz.all.published.map { |q| [q.id, q.solved_times_by(user)] }
  #   quiz_number =  quizzes_number.sort { |a, b| a[1] <=> b[1] }[0..len].sample[0]
  #   find(quiz_number)
  # end

  # private
  # # 画像のバリデーション(png,jpeg)
  # def image_type
  #   # return unless
  #   byebug
  #   if !image.present?
  #     if !image.blob.content_type.in?(%('image/jpeg image/png'))
  #       image.purge
  #       errors.add(:image, 'はJPEGまたはPNG形式を選択してアップロードしてください')
  #     end
  #   end
  # end
end
