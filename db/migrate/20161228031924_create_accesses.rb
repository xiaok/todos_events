class CreateAccesses < ActiveRecord::Migration[5.0]
  def self.up
    create_table :accesses do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.string :role
      t.timestamps
    end
  end

  def self.down
    drop_table :accesses
  end
end
