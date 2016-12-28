class CreateTeams < ActiveRecord::Migration[5.0]
  def self.up
    create_table :teams do |t|
      t.string :name, null: false
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
