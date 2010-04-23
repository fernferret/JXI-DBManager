class Column < ActiveRecord::Base
  belongs_to :table
  validates_presence_of :name, :table, :column_type, :null
  validates_uniqueness_of :name, :scope => :table_id
end
