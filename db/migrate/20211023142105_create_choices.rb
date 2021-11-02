# frozen_string_literal: true

class CreateChoices < ActiveRecord::Migration[5.2]
  def change
    create_table :choices do |t|
      t.integer :quiz_id, null: false
      t.string :content, null: false
      t.boolean :is_answer, null: false

      t.timestamps
    end
  end
end
