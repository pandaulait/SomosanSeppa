# is_answersの正気化
def normalize(array)
  flag = 0
  i = 0
  true_count = 0
  while flag == 0
    if i <=  (array.count - 2)
      if array[i] == "0" && array[i+1] == "1"
        array.delete_at(i)
        true_count += 1
      end
      i += 1
    else
      flag = 1
    end
  end
  array.push(true_count)
  return array
end


class Choice < ApplicationRecord
  validates :content, presence: true, length: { maximum: 100 }
  belongs_to :quiz
  def self.choice_update(choices, quiz_id, is_answers, choice_ids)
    normalize(is_answers)
    # Choiceのcontentが""出ない場合、is_answerと合わせて保存する。
    all_valid = true
    all_valid = false if choices.count == 0
    Choice.transaction(joinable: false, requires_new: true) do
      i = 0
      while i < choices.count
        if choices[i].present?
          choice = Choice.find(choice_ids[i])
          all_valid &= choice.update(content: choices[i], is_answer: is_answers[i], quiz_id: quiz_id)
        end
        i+=1
        if is_answers[i] == true
          true_count += 1
        end
      end
      # 回答がない場合、やり直し
      if is_answers[-1] < 1
        all_valid = false
      end
      unless all_valid
        raise ActiveRecord::Rollback
      end
    end
    all_valid
  end


  def self.choice_create(choices, quiz_id, is_answers)
    # @is_answer を正規化
    normalize(is_answers)
    # Choiceのcontentが""出ない場合、is_answerと合わせて保存する。
    all_valid = true
    Choice.transaction(joinable: false, requires_new: true) do
      i = 0
      while i < choices.count
        if choices[i].present?
          choice = Choice.new(content: choices[i], is_answer: is_answers[i], quiz_id: quiz_id)
          all_valid &= choice.save
        end
        i+=1
      end
      # 回答がない場合、やり直し
      if is_answers[-1] < 1
        all_valid = false
        Quiz.find(quiz_id).errors.add(:base, '正解はひとつ以上設定してください。')
      end

      unless all_valid
        raise ActiveRecord::Rollback
      end
    end
    all_valid
  end
end
