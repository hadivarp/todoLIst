class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :status
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :due_date
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
