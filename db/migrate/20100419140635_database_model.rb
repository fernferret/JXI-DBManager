class DatabaseModel < ActiveRecord::Migration
  def self.up
    create_table :databases do |t|
     t.integer :user_id
     t.string :name
    end
  end

  def self.down
    drop_table :databases
  end
end
