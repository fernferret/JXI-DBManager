class Database < ActiveRecord::Base
  has_many :tables
  belongs_to :user
  validates_presence_of :name, :user
  validates_associated :user
  validates_uniqueness_of :name, :scope => :user_id
  
  def exists_with_title(name)
    return true
  end
end
