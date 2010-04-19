class Table < ActiveRecord::Base
  has_many :columns
  belongs_to :table
  validates_presence_of :name
end
