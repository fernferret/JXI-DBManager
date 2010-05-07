class Database < ActiveRecord::Base
  has_many :tables
  belongs_to :user
  validates_presence_of :name, :user
  # validates_associated :user
  validates_uniqueness_of :name, :scope => :user_id

  def exists_with_title(name)
    return true
  end
  
  def destroy_database(user)
    if self.user == user || user.permissions == "admin"
      return true
    else
      return false
    end
  end

  def edit_database(user)
    if self.user == user || user.permissions == "admin"
      return true
    else
      return false
    end
  end

  def view_database(user)
    if self.user == user || user.permissions == "ta" || user.permissions == "admin"
      return true
    else
      return false
    end
  end
  
  def create_dbsql
    return "CREATE DATABASE " + self.name
  end
  
  def rename_dbsql(dbName)
    return "ALTER DATABASE " + self.name + " MODIFY NAME = " + dbName
  end
  
  def drop_dbsql
    return "DROP DATABASE " + self.name
  end
  
  def use_dbsql
    return "USE dbo." + self.name
  end
end
