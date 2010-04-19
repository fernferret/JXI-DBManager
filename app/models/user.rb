class User < ActiveRecord::Base
  has_many :databases
  validates_presence_of :username, :name, :password
end
