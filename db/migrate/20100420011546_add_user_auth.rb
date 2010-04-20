class AddUserAuth < ActiveRecord::Migration
  def self.up
    add_column :users, :crypted_password, :string
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
  end

  def self.down
    remove_column :users, :password
  end
end
