class AddUserToTasksAndCategory < ActiveRecord::Migration[7.2]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
    add_reference :categories, :user, null: true, foreign_key: true
  end
end
