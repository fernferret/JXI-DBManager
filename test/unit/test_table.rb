# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
# require 'mocha'

class TableTest < ActiveSupport::TestCase
  def test_add_all_criteria
    table = Factory.create(:table)
    assert table.save, 'Could not save a new Table!'
  end

  def test_should_not_save_with_no_title
    # Create a new table with no name
    table = Factory.create(:table)
    # Grab the ID from that table and increment it by one
    prev_table_id = Integer(table.name.match(/\d+/)[0])
    prev_table_id += 1
    # Add another new table without name (testing to see)
    # if the first one and this one were both successfylly added
    # with no names
    new_table = Factory.build(:table)
    assert_equal new_table.name, 'Table'+prev_table_id.to_s, 'Saved a new Table with no title!'  
  end

  def test_should_not_save_with_no_database
    table = Factory.build(:table, :database => nil)
    assert !table.save, 'Saved a new table with no database!'
  end

  def test_should_not_save_table_with_same_name
    database = Factory.create(:database)
    table = Factory.create(:table, :name => 'Same Name', :database => database)
    table2 = Factory.build(:table, :name => 'Same Name', :database => database)
    assert !table2.valid?, 'Saved a table with a duplicate name!'
  end

  def test_delete_table
    table = Factory.create(:table)
    assert table.destroy, 'Unable to destroy table'
  end

  def test_edit_own_table
    table = Factory.create(:table, :name => 'Boring Table')
    assert table.update_attributes(:name => 'Sweet Table'), 'Could not update table'
  end
end
