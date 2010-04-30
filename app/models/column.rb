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
		if self.table.database.user == user || user.permissions == "admin"
			return true
		else
			return false
		end
	end

  def view_column(user)
    if self.table.database.user == user || user.permissions == "ta" || user.permissions == "admin"
      return true
    else
      return false
    end
  end

end
