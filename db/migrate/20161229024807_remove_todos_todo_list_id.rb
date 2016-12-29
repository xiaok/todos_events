class RemoveTodosTodoListId < ActiveRecord::Migration[5.0]
  def change
    remove_index :todos, :todo_list_id
    remove_column :todos, :todo_list_id
  end
end
