class SetTodosIsCompleteDefaultValue < ActiveRecord::Migration[5.0]
  def change
    change_column_default :todos, :is_complete, false
  end
end
