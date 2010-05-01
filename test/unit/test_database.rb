# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

class DatabaseTest < ActiveSupport::TestCase
  def setup

    @userA = Factory.create(:user)
    @userB = Factory.create(:user)
    @adminUser = Factory.create(:user, :permissions => "admin")
    @taUser = Factory.create(:user, :permissions => "ta")
  end

  # Test that a basic database with name can be added.
  def test_add_all_criteria
    #    Sample use of the factory
    database = Factory.create(:database, :name => "test")
    assert database.save, 'Could not save a new Database!'
  end

  # Test that the database will not save without a title.
  def test_should_not_save_with_no_title
    # Create a new database with no name
    database = Factory.create(:database)
    # Grab the ID from that database and increment it by one
    prev_db_id = Integer(database.name.match(/\d+/)[0])
    prev_db_id += 1
    # Add another new database without name (testing to see)
    # if the first one and this one were both successfylly added
    # with no names
    new_db = Factory.build(:database)
    assert_equal new_db.name, 'My DB'+prev_db_id.to_s, 'Saved a new Database with no title!'    
  end

  # Test that a database will not save without a user.
  def test_should_not_save_with_no_user
    database = Factory.build(:database, :user => nil)
    assert !database.valid?, 'Saved a new Database with no user!'
  end

  # Test that a user can create different databases as long as they are named differently.
  def test_user_can_create_multiple_databases_with_unique_names
    databaseA = Factory.create(:database, :user => @userA)
    databaseB = Factory.build(:database, :user => @userA)
    assert databaseB.valid?, 'Could not add another database for user!'
  end

  # Test that a user cannot create two database with the same name
  def test_should_not_save_database_with_same_name_per_user
    database_old = Factory.create(:database, :name => 'My First Database', :user => @userA)
    database_new = Factory.build(:database, :name => 'My First Database', :user => @userA)
    http://www.intellicast.com/National/Radar/Current.aspx?location=USOH0124&animate=truehttp://www.intellicast.com/National/Radar/Current.aspx?location=USOH0124&animate=truehttp://www.intellicast.com/National/Radar/Current.aspx?location=USOH0124&animate=trueassert !database_new.valid?, 'Saved a database with a duplicate name!'
  end

  #Destroy

  # Test that a database can be deleted successfully
  def test_delete_database
    database = Factory.create(:database, :user => @userA) 
    assert database.destroy_database(@userA), 'Unable to destroy database'
  end

  # Test that an admin can delete anyone's database
  def test_admin_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.destroy_database(@adminUser), 'Admin could not delete database'
  end

  # Test that a ta cannot delete another user's database.
  def test_ta_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.destroy_database(@taUser), 'TA could delete database'
  end

  # Test that a general user cannot delete someone else's database.
  def test_user_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.destroy_database(@userB), 'User could delete someone else\'s database'
  end

  #Edit

  # Test that a database can be edited successfully
  def test_edit_database
    database = Factory.create(:database, :user => @userA, :name => 'My Database') 
    assert database.edit_database(@userA), 'Unable to destroy database'
  end

  # Test that an admin can edit anyone's database
  def test_admin_edit_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.edit_database(@adminUser), 'Admin could not edit database'
  end

  # Test that a ta cannot edit someone else's database
  def test_ta_edit_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert !database.edit_database(@taUser), 'TA could edit database'
  end

  # Test that a general user cannot edit anyone's databases but their own.
  def test_user_edit_someone_elses_database_with_permissions
    flunk("Not a test case for the current release")
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.edit_database(@userB), 'User could edit someone else\'s database'
  end
  http://www.intellicast.com/National/Radar/Current.aspx?location=USOH0124&animate=truehttp://www.intellicast.com/National/Radar/Current.aspx?location=USOH0124&animate=true
  # Test that the user cannot edit someone else's database with it being shared.
  def test_user_edit_someone_elses_database_without_permissions
    flunk("Not a test case for the current release")
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert !database.edit_database(@userB), 'User could edit someone else\'s database'
  end

  # Test that you can succesfully alter your own databases. 
  def test_edit_own_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.update_attributes(:name => 'Newer Database'), 'Could not update database'
  end

  #View

  # Test that a user can view  database.
  def test_view_database
    database = Factory.create(:database, :user => @userA)     def test_alter_sql_database
    dbname = "My first database"
    newname = "My newer database"
    database = Factory.create(:database, :name => dbname, :user => @userA)
    assert_equal "ALTER DATABASE " + dbname + " MODIFY NAME = " + newname,database.rename_dbsql(newname), 'Could not change name'
  end
    assert database.view_database(@userA), 'Unable to view database'
  end

  # Test that an admin can view any database.
  def test_admin_view_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert database.view_database(@adminUser), 'Admin could not view database'
  end

  # Test that a ta can view any database.
  def test_ta_view_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.view_database(@taUser), 'TA could not view database'
  end

  # Test that a general user can view anyone else's database with permiss    def test_alter_sql_database
    dbname = "My first database"
    newname = "My newer database"
    database = Factory.create(:database, :name => dbname, :user => @userA)
    assert_equal "ALTER DATABASE " + dbname + " MODIFY NAME = " + newname,database.rename_dbsql(newname), 'Could not change name'
  endion
  def test_user_view_someone_elses_database_with_permissions
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert !database.view_database(@userB), 'User could view someone else\'s database'
  end

  # Test that a general user cannot view anyone else's databases without permission
  def test_user_view_someone_elses_database_without_permissions
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert !database.view_database(@userB), 'User could view someone else\'s database'
  end

  # TESTING SQL COMMANDS
  def test_add_sql_database
    dbname = "My first database"
    database = Factory.create(:database, :name => dbname, :user => @userA)
    assert_equal "CREATE DATABASE " + dbname,database.create_dbsql, 'Did not generate valid SQL'
  end

  def test_alter_sql_database
    dbname = "My first database"
    newname = "My newer database"
    database = Factory.create(:database, :name => dbname, :user => @userA)
    assert_equal "ALTER DATABASE " + dbname + " MODIFY NAME = " + newname,database.rename_dbsql(newname), 'Could not change name'
  end

  def test_drop_sql_database
    dbname = "My first database"
    newname = "My newer database"
    database = Factory.create(:database, :name => dbname, :user => @userA)
    assert_equal "DROP DATABASE " + dbname,database.drop_dbsql, 'Could not drop database in SQL'
  end
end
