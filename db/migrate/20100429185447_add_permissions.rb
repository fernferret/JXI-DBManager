class AddPermissions < ActiveRecord::Migration
  def self.up
		add_column :users, :permissions, :string
  end

  def self.down
		remove_column :users, :permissions
  end
end
