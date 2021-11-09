class RenameExpColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :exp, :experience_point
  end
end
