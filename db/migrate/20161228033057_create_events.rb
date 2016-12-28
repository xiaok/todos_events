class CreateEvents < ActiveRecord::Migration[5.0]
  def up
    create_table :events do |t|
      t.references :eventable, polymorphic: true
      t.text :extra
      t.string :type
      t.belongs_to :user
      t.belongs_to :project
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
