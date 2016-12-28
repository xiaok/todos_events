class TodosAddProjectId < ActiveRecord::Migration[5.0]
  def change
    drop_table :todo_lists

    add_column :todos, :project_id, :integer
    add_index :todos, :project_id
  end
end
