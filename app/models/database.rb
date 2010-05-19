require 'mysql'

class Database < ActiveRecord::Base
  has_many :tables
  belongs_to :user
  has_and_belongs_to_many :users
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
    if self.user == user || user.permissions == "admin" || @users != nil && @users.include?(user)
      return true
    else
      return false
    end
  end

  def view_database(user)
    if @user == user || user.permissions == "ta" || user.permissions == "admin" || (@users != nil && @users.include?(user)) 
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
    return "USE " + self.name
  end

  def share_with_user(user)
    if (user != nil)
      @users << user
    end
  end

  def unshare_with_user(user)
  end

  def issue_query(user, query, db)
    if edit_database(user)
			db.query(query)
    end
  end
end
