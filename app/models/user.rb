class User < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation, :email
  acts_as_authentic
  validates_presence_of :username, :name, :password, :email
	validates_uniqueness_of :email
  has_many :databases
end
