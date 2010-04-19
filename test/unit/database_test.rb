# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
require 'mocha'

class DatabaseTest < ActiveSupport::TestCase
  def test_add_all_criteria
#    Sample use of the factory
    database = Factory.create(:database)
    assert database.save, 'Could not save a new Database!'
  end

  def test_should_not_save_with_no_title
    database = Factory.create(:database, :name => nil)
    # database = Database.new
    assert !database.save, 'Saved a new Database with no title!'    
  end

  def test_should_not_save_with_no_user
    database = Database.new
    database.name = 'My new database'
    assert !database.save, 'Saved a new Database with no user!'
  end

  def test_should_not_save_database_with_same_name
    database = Factory.create(:database, :name => 'My First Database')
    assert database.exists_with_title('My First Database'), 'Test Table does not exist, cannot proceed'
    database = Database.new
    database.title = 'My First Database'
    database.user_id = 1
    assert !database.save, 'Saved a database with a duplicate name!'
  end

  def test_user_must_be_logged_in_to_create_database
    flunk('Will be implemented when Auth is decided upon')
  end

  def test_delete_database
    database = Factory.create(:database) 
    assert database.destroy, 'Unable to destroy database'
  end

  def test_delete_someone_elses_database
    userA = Factory.create(:user)
    userB = Factory.create(:user)
    database = Factory.create(:database, :name => 'My First Database', :user => userA)
    assert database.exists_with_title('My First Database'), 'Test Table does not exist, cannot proceed'
    my_id = 2
    assert !database.destroy, 'I destroyed someone else\'s database!'
  end

  def test_edit_own_database
    userA = Factory.create(:user)
    userB = Factory.create(:user)
    database = Factory.create(:database, :name => 'My First Database', :user => userA)
    assert database.exists_with_title('My First Database'), 'Test Table does not exist, cannot proceed'
    database.title = 'Newer Database'
    assert userA == userA, 'Users are not the same'
    assert database.update_attributes, 'Could not update database'
  end
end
