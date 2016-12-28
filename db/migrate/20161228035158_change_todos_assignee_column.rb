class ChangeTodosAssigneeColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :todos, :assignee if column_exists?(:todos, :assignee)
    add_column :todos, :assignee_id, :integer
    add_index :todos, :assignee_id
  end
end
