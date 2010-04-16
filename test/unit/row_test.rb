# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
require 'mocha'

class TableTest < ActiveSupport::TestCase
  def test_add_all_criteria
    table = Table.new
    table.title = 'My new table'
    table.database.id = 1
    assert table.save, 'Could not save a new Table!'
  end

  def test_should_not_save_with_no_title
    table = Table.new
    table.database.id = 1
    assert !table.save, 'Saved a new Table with no title!'    
  end

  def test_should_not_save_with_no_user
    table = Table.new
    table.title = 'My new table'
    assert !table.save, 'Saved a new Table with no user!'
  end

  def test_should_not_save_table_with_same_name
    assert table.exists_with_title('My First Table'), 'Test Table does not exist, cannot proceed'
    table = Table.new
    table.title = 'My First Table'
    table.database.id = 1
    assert !table.save, 'Saved a table with a duplicate name!'
  end

  def test_user_must_be_logged_in_to_create_table
    flunk('Will be implemented when Auth is decided upon')
  end

  def test_delete_table
    assert table.exists_with_title('My First Table'), 'Test Table does not exist, cannot proceed'
    my_id = 1
    table = @table1
    assert table.destroy, 'Unable to destroy table'
  end

  def test_delete_someone_elses_table
    assert table.exists_with_title('My First Table'), 'Test Table does not exist, cannot proceed'
    my_id = 2
    table = @table1
    assert !table.destroy, 'I destroyed someone else\'s table!'
  end

  def test_edit_own_table
    assert table.exists_with_title('My First Table'), 'Test Table does not exist, cannot proceed'
    my_id = 1
    table = @table1
    table.title = 'Newer Table'
    assert table.update_attributes, 'Could not update table'
  end
end
