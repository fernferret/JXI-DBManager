class Database < ActiveRecord::Base
  has_many :tables
  belongs_to :user
  validates_presence_of :name, :user_id
end
