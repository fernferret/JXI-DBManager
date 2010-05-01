# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
require 'mocha'

class ColumnTest < ActiveSupport::TestCase
	def setup
		@userA = Factory.create(:user)
		@databaseA = Factory.create(:database, :user => @userA)
		@tableA = Factory.create(:table, :database => @databaseA)
		@userB = Factory.create(:user)
		@userAdmin = Factory.create(:user)
		@userTA = Factory.create(:user)
		@columnA = Factory.create(:column, :table => @tableA)
	end

  # Test setting up a new column
  def test_add_all_criteria
    column = Factory.create(:column)
    assert column.save, 'Could not save a new Column!'
  end

  # Test that a column shouldn not save without a name.
  def test_should_not_save_with_no_name
    # Create a new column with no name
    column = Factory.create(:column)
    # Grab the ID from that column and increment it by one
    prev_column_id = Integer(column.name.match(/\d+/)[0])
    prev_column_id += 1
    # Add another new column without name (testing to see)
    # if the first one and this one were both successfylly added
    # with no names
    new_column = Factory.build(:column)
    assert_equal new_column.name, 'Column'+prev_column_id.to_s, 'Saved a new Column with no name!'  
  end
  
  #Test that a column should not save without a type (string, int,etc.)
  def test_should_not_save_with_no_column_type
    column = Factory.build(:column, :column_type => nil)
    assert !column.save, 'Saved a new Column with no column_type!'    
  end
  
  #Test that the column should not save without a is null.
  def test_should_not_save_with_no_null
    column = Factory.build(:column, :null => nil)
    assert !column.save, 'Saved a new Column with no null!'    
  end

  # Test that a column should not save without a table associated with it
  def test_should_not_save_with_no_table
    column = Factory.build(:column, :table => nil)
    assert !column.save, 'Saved a new Column with no table!'
  end

  #Test that a column should not save if there already exists one with that name on the same table.
  def test_should_not_save_column_with_same_name
    table = Factory.create(:table)
    column = Factory.create(:column, :name => 'Same Name', :table => table)
    column2 = Factory.build(:column, :name => 'Same Name', :table => table)
    assert !column2.valid?, 'Saved a column with a duplicate name!'
  end

  # Test that we can delete a column properly.
  def test_delete_column
    column = Factory.create(:column)
    assert column.destroy, 'Unable to destroy column'
  end

#destroy

  #Test that the column is properly destroyed.
	def test_destroy_column
		assert @columnA.destroy_column(@userA), 'User was unable to destroy column'
	end

  # Test that the column cannot be destroyed by another general user.
	def test_destroy_someone_elses_column
		assert !@columnA.destroy_column(@userB), 'User could delete someone else\'s column'
	end

#edit

  #Test that the column can be properly edited
  def test_edit_own_column
    assert @columnA.edit_column(@userA), 'Could not update column'
  end

  # Test that the column cannot be edited by a general user
	def test_edit_someone_elses_column
    assert !@columnA.edit_column(@userB), 'User could update someone else\'s column'
  end

  #Test that an admin can edit any column
	def admin_can_edit_someone_elses_column
		assert @columnA.edit_column(@userAdmin), 'Admin could edit someone else\'s column'
	end

  #Test that a TA cannot edit other people's information
	def ta_cant_edit_someone_elses_column
		assert !@columnA.edit_column(@userTA), 'TA could edit someone else\'s column'
	end
	
	# Test that a user can edit their own column name
	def test_edit_own_column_name
	  @columnA.name = 'column name'
		assert @columnA.update_attributes(:name => 'new column'), 'Could not update column\'s name'
	end
	
	# Test that a user can edit their own column types
	def test_edit_own_column_type
	  @columnA.column_type = 'ints'
		assert @columnA.update_attributes(:column_type => 'string'), 'Could not update column\'s type'
	end
	
	# Test that a user can edit their own is null checks
	def test_edit_own_column_null
	  @columnA.null = 'f'
		assert @columnA.update_attributes(:null => 't'), 'Could not update column\'s null field'
	end

#view

  #Test that you can view your own columns.
	def test_view_own_column
    assert @columnA.view_column(@userA), 'Could not view column'
  end
	
	#Test that a general user cannot view someone else's columns.	
	def test_view_someone_elses_column
    assert !@columnA.view_column(@userB), 'User could view someone else\'s column'
  end

  #Test that an admin can see any column
	def admin_can_view_someone_elses_column
		assert !@columnA.view_column(@userAdmin), 'Admin not could view someone else\'s column'
	end

  #Test that a ta cannot view someone else's column
	def ta_cant_view_someone_elses_column
		assert !@columnA.view_column(@userTA), 'TA could view someone else\'s column'
	end
  # TESTING SQL COMMANDS
  def test_add_sql_column
    database = Factory.create(:database)
    table = Factory.create(:table, :database => database)
    column = Factory.create(:column, :table => table)
    assert_equal "USE dbo." + database.name, database.use_dbsql, 'Did not generate valid SQL'

    assert_equal "ALTER TABLE " + tablename, table.alter_dbsql, 'Did not generate valid SQL'

    assert_equal "ADD " + column.name + " " + column.column_type, column.add_dbsql, 'Did not generate valid SQL'
  end

  def test_alter_sql_column
    database = Factory.create(:database)
    table = Factory.create(:table, :database => database)
    column = Factory.create(:column, :table => table)
    assert_equal "USE dbo." + database.name, database.use_dbsql, 'Did not generate valid SQL'

    assert_equal "ALTER TABLE " + tablename, table.alter_dbsql, 'Did not generate valid SQL'

    assert_equal "ALTER COLUMN " + column.name + " " + column.column_type, column.alter_dbsql, 'Did not generate valid SQL'
  end

  def test_drop_sql_column
    database = Factory.create(:database)
    table = Factory.create(:table, :database => database)
    column = Factory.create(:column, :table => table)
    assert_equal "USE dbo." + database.name, database.use_dbsql, 'Did not generate valid SQL'

    assert_equal "ALTER TABLE " + tablename, table.alter_dbsql, 'Did not generate valid SQL'

    assert_equal "DROP COLUMN " + column.name, column.drop_dbsql, 'Did not generate valid SQL'
  end
end
