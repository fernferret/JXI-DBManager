# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
require 'mocha'

class ColumnTest < ActiveSupport::TestCase
  def test_add_all_criteria
    column = Column.new
    column.title = 'My new column'
    column.table.id = 1
    assert column.save, 'Could not save a new Column!'
  end

  def test_should_not_save_with_no_title
    column = Column.new
    column.table.id = 1
    assert !column.save, 'Saved a new Column with no title!'    
  end

  def test_should_not_save_with_no_user
    column = Column.new
    column.title = 'My new table'
    assert !column.save, 'Saved a new Column with no user!'
  end

  def test_should_not_save_column_with_same_name
    assert column.exists_with_title('My First Column'), 'Test Column does not exist, cannot proceed'
    column = Column.new
    column.title = 'My First Column'
    column.table.id = 1
    assert !column.save, 'Saved a column with a duplicate name!'
  end

  def test_user_must_be_logged_in_to_create_column
    flunk('Will be implemented when Auth is decided upon')
  end

  def test_delete_column
    assert column.exists_with_title('My First Column'), 'Test Column does not exist, cannot proceed'
    my_id = 1
    column = @column1
    assert column.destroy, 'Unable to destroy column'
  end
end
