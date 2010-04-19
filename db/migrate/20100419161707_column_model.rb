class ColumnModel < ActiveRecord::Migration
  def self.up
    create_table :columns do |t|
      t.string :name
      t.integer :table_id
      t.string :column_type
      t.boolean :null
    end
  end

  def self.down
    drop_table :columns
  end
end
