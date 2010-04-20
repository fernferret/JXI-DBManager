# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
require 'mocha'

class DatabaseTest < ActiveSupport::TestCase
  def setup
    @userA = Factory.create(:user)
    @userB = Factory.create(:user)
  end
  def test_add_all_criteria
#    Sample use of the factory
    database = Factory.create(:database)
    assert database.save, 'Could not save a new Database!'
  end

  def test_should_not_save_with_no_title
    database = Factory.build(:database, :name => nil)
    assert !database.valid?, 'Saved a new Database with no title!'    
  end

  def test_should_not_save_with_no_user
    database = Factory.build(:database, :user => nil)
    assert !database.valid?, 'Saved a new Database with no user!'
  end

  def test_user_can_create_multiple_databases_with_unique_names
    databaseA = Factory.create(:database, :user => @userA)
    databaseB = Factory.build(:database, :user => @userA)
    assert databaseB.valid?, 'Could not add another database for user!'
  end

  def test_should_not_save_database_with_same_name_per_user
    flunk('Will be implemented when Auth is decided upon')
    database_old = Factory.create(:database, :name => 'My First Database', :user => @userA)
    database_new = Factory.build(:database, :name => 'My First Database', :user => @userA)
    assert !database_new.valid?, 'Saved a database with a duplicate name!'
  end

  def test_user_must_be_logged_in_to_create_database
    flunk('Will be implemented when Auth is decided upon')
  end

  def test_delete_database
    database = Factory.create(:database) 
    assert database.destroy, 'Unable to destroy database'
  end

  def test_delete_someone_elses_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    assert database.exists_with_title('My First Database'), 'Test Table does not exist, cannot proceed'
    my_id = 2
    assert !database.destroy, 'I destroyed someone else\'s database!'
  end

  def test_edit_own_database
    database = Factory.create(:database, :name => 'My First Database', :user => @userA)
    database.name = 'Newer Database'
    assert database.update_attributes(:name => 'Test'), 'Could not update database'
  end
end
