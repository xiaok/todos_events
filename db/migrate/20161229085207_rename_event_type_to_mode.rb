class RenameEventTypeToMode < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :type, :mode
  end
end
