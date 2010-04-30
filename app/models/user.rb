class User < ActiveRecord::Base
  attr_accessible :username, :name, :password, :password_confirmation, :email
  acts_as_authentic
  validates_presence_of :username, :name, :password, :email
  validates_uniqueness_of :email, :username
  validates_format_of :email, :with => /^[A-Za-z_0-9!$%&'*+\/=?^`{|}~.-][^.]+@[^.][A-Za-z_0-9!$%&'*+\/=?^`{|}~-]+\.[a-zA-Z.]+[^.]$/, :on => :create
  has_many :databases
end
