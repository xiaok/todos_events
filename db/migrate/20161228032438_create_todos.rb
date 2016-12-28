class CreateTodos < ActiveRecord::Migration[5.0]
  def self.up
    create_table :todos do |t|
      t.string :name
      t.belongs_to :todo_list
      t.integer :due_at
      t.integer :assignee
      t.boolean :is_complete
      t.timestamps
    end
  end

  def self.down
    drop_table :todos
  end
end
