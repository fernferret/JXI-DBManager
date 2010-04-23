class User < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation
  acts_as_authentic
  validates_presence_of :username, :name, :password
  has_many :databases
end
