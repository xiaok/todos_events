class ChangeDueAtIntToTimestamp < ActiveRecord::Migration[5.0]
  def change
    change_column :todos, :due_at, :timestamp
  end
end
