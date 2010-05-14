class AddUserSharing < ActiveRecord::Migration
  def self.up
    create_table :databases_users, :id => false do |t|
      t.integer :database_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :databases_users
  end
end

