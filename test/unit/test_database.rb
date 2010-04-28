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
  def test_add_all_criteria
#    Sample use of the factory
    database = Factory.create(:database, :name => "test")
    assert database.save, 'Could not save a new Database!'
  end

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

  def test_should_not_save_with_no_user
    #flunk('Will be implemented when Auth is decided upon')
    database = Factory.build(:database, :user => nil)
    assert !database.valid?, 'Saved a new Database with no user!'
  end

  def test_user_can_create_multiple_databases_with_unique_names
    databaseA = Factory.create(:database, :user => @userA)
    databaseB = Factory.build(:database, :user => @userA)
    assert databaseB.valid?, 'Could not add another database for user!'
  end

  def test_should_not_save_database_with_same_name_per_user
    database_old = Factory.create(:database, :name => 'My First Database', :user => @userA)
    database_new = Factory.build(:database, :name => 'My First Database', :user => @userA)
    assert !database_new.valid?, 'Saved a database with a duplicate name!'
  end

#Destroy
  def test_delete_database
    database = Factory.create(:database, :user => @userA) 
    assert database.destroy_database(@userA), 'Unable to destroy database'
  end

  def test_admin_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert database.destroy_database(@adminUser), 'Admin could not delete database'
  end

  def test_ta_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.destroy_database(@taUser), 'TA could delete database'
  end

  def test_user_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.destroy_database(@userB), 'User could delete someone else\'s database'
  end

#Edit
  def test_delete_database
    database = Factory.create(:database, :user => @userA) 
    assert database.edit_database(@userA), 'Unable to destroy database'
  end

  def test_admin_edit_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert database.edit_database(@adminUser), 'Admin could not edit database'
  end

  def test_ta_edit_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.edit_database(@taUser), 'TA could edit database'
  end

  def test_user_edit_someone_elses_database_with_permissions
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.edit_database(@userB), 'User could edit someone else\'s database'
  end

  def test_user_edit_someone_elses_database_without_permissions
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.edit_database(@userB), 'User could edit someone else\'s database'
  end

  def test_edit_own_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.update_attributes(:name => 'Newer Database'), 'Could not update database'
  end

#View
  def test_view_database
    database = Factory.create(:database, :user => @userA) 
    assert database.view_database(@userA), 'Unable to destroy database'
  end

  def test_admin_view_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert database.view_database(@adminUser), 'Admin could not view database'
  end

  def test_ta_view_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.view_database(@taUser), 'TA could view database'
  end

  def test_user_view_someone_elses_database_with_permissions
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.view_database(@userB), 'User could view someone else\'s database'
  end

  def test_user_view_someone_elses_database_without_permissions
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)

    assert !database.view_database(@userB), 'User could view someone else\'s database'
  end

  def test_edit_own_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.update_attributes(:name => 'Newer Database'), 'Could not update database'
  end
end
