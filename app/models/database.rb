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
      self.destroy
    end
  end

  def edit_database(user, params)
    if self.user == user || user.permissions == "admin"
      self.update_attributes(params)
    end
  end

  def view_database(user)
    if self.user == user || user.permissions == "ta" || user.permissions == "admin"
      return true
    else
      return false
    end
  end
end
