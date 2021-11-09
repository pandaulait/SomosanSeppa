require 'rails_helper'

RSpec.describe SelectionQuiz, type: :model do
  describe 'バリデーションテスト' do
    subject { selection_quiz.valid? }

    let(:selection_quiz) { build(:selection_quiz) }
    context 'contentカラム' do
      it '空欄でないこと' do
        selection_quiz.content = ''
        is_expected.to eq false
      end
      it '3文字以上であること: 2文字は×' do
        selection_quiz.content = Faker::Lorem.characters(number: 2)
        is_expected.to eq false
      end
      it '3文字以上であること: 3文字は〇' do
        selection_quiz.content = Faker::Lorem.characters(number: 3)
        is_expected.to eq true
      end
      it '200文字以下であること: 200文字は〇' do
        selection_quiz.content = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        selection_quiz.content = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
    context 'explanationカラム' do
      it '空欄でないこと' do
        selection_quiz.explanation = ''
        is_expected.to eq false
      end
      it '3文字以上であること: 2文字は×' do
        selection_quiz.explanation = Faker::Lorem.characters(number: 2)
        is_expected.to eq false
      end
      it '3文字以上であること: 3文字は〇' do
        selection_quiz.explanation = Faker::Lorem.characters(number: 3)
        is_expected.to eq true
      end
      it '500文字以下であること: 500文字は〇' do
        selection_quiz.explanation = Faker::Lorem.characters(number: 500)
        is_expected.to eq true
      end
      it '500文字以下であること: 501文字は×' do
        selection_quiz.explanation = Faker::Lorem.characters(number: 501)
        is_expected.to eq false
      end
    end
  end
end
