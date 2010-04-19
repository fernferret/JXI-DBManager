class TableModel < ActiveRecord::Migration
  def self.up
    create_table :tables do |t|
      t.integer :database_id
      t.string :name
    end
  end

  def self.down
    drop_table :tables
  end
end
