class Column < ActiveRecord::Base
  belongs_to :table
  validates_presence_of :table
end
