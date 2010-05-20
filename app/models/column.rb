class Column < ActiveRecord::Base
  belongs_to :table
  validates_presence_of :name, :table, :column_type, :null
  validates_uniqueness_of :name, :scope => :table_id

	def destroy_column(user)
		if self.table.database.user == user || user.permissions == "admin"
			return true
		else
			return false
		end
	end

	def edit_column(user)
		if self.table.database.user == user || user.permissions == "admin" || (self.table.database.users != nil && self.table.database.users.include?(user))
			return true
		else
			return false
		end
	end

  def view_column(user)
    if self.table.database.user == user || user.permissions == "ta" || user.permissions == "admin" || (self.table.database.users != nil && self.table.database.users.include?(user))
      return true
    else
      return false
    end
  end
  
  def add_dbsql
    return "ADD " + self.name + " " + self.column_type
  end
  
  def alter_dbsql(aColumnType)
    return "ALTER COLUMN " + self.name + " " + aColumnType
  end
  
  def rename_column(aColumnName)
    return "CHANGE " + self.name + " " + aColumnName + " " + self.column_type
  end
  
  def drop_dbsql
    return "DROP COLUMN " + self.name
  end
    
end
