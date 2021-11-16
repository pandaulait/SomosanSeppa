class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :subject, polymorphic: true
      t.references :user, foreign_key: true
      t.string :content, null: false, default: ""
      t.integer :action_type, null: false
      t.boolean :read, nul: false, default: false

      t.timestamps
    end
  end
end