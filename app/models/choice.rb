# is_answersの正気化
def normalize(array)
  flag = 0
  i = 0
  true_count = 0
  while flag == 0
    if i <=  (array.count - 2)
      if array[i] == '0' && array[i + 1] == '1'
        array.delete_at(i)
        true_count += 1
      end
      i += 1
    else
      flag = 1
    end
  end
  array.push(true_count)
  array
end

class Choice < ApplicationRecord
  validates :content, presence: true, length: { maximum: 100 }
  belongs_to :selection_quiz
  def self.choice_update(choices, selection_quiz_id, is_answers, choice_ids)
    normalize(is_answers)
    # Choiceのcontentが""出ない場合、is_answerと合わせて保存する。
    all_valid = true
    all_valid = false if choices.count == 0
    Choice.transaction(joinable: false, requires_new: true) do
      i = 0
      while i < choices.count
        if choices[i].present?
          choice = Choice.find(choice_ids[i])
          all_valid &= choice.update(content: choices[i], is_answer: is_answers[i],
                                     selection_quiz_id: selection_quiz_id)
        end
        i += 1
        true_count += 1 if is_answers[i] == true
      end
      # 回答がない場合、やり直し
      all_valid = false if is_answers[-1] < 1
      raise ActiveRecord::Rollback unless all_valid
    end
    all_valid
  end

  def self.choice_create(choices, selection_quiz_id, is_answers)
    # @is_answer を正規化
    normalize(is_answers)
    # Choiceのcontentが""出ない場合、is_answerと合わせて保存する。
    all_valid = true
    Choice.transaction(joinable: false, requires_new: true) do
      i = 0
      while i < choices.count
        if choices[i].present?
          choice = Choice.new(content: choices[i], is_answer: is_answers[i], selection_quiz_id: selection_quiz_id)
          all_valid &= choice.save
        end
        i += 1
      end
      all_valid = false if SelectionQuiz.find(selection_quiz_id).choices.count < 2

      # 回答がない場合、やり直し
      if is_answers[-1] < 1
        all_valid = false
        SelectionQuiz.find(selection_quiz_id).errors.add(:base, '正解はひとつ以上設定してください。')
      end

      raise ActiveRecord::Rollback unless all_valid
    end
    all_valid
  end
end
