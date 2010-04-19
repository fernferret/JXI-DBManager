class User < ActiveRecord::Base
  has_many :databases
end
