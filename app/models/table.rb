class Table < ActiveRecord::Base
  has_many :columns
  belongs_to :database
  validates_presence_of :name
end
