# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
# require 'mocha'


class TableTest < ActiveSupport::TestCase
	def setup
		@userA = Factory.create(:user)
		@databaseA = Factory.create(:database, :user => @userA)
		@tableA = Factory.create(:table, :database => @databaseA)
		@userB = Factory.create(:user)
		@userAdmin = Factory.create(:user)
		@userTA = Factory.create(:user)
	end

  # Test that a basic table can be created.
  def test_add_all_criteria
    table = Factory.create(:table)
    assert table.save, 'Could not save a new Table!'
  end

  # Test that a table should not save without a title
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

  # Test that a basic table should not save without a database.
  def test_should_not_save_with_no_database
    table = Factory.build(:table, :database => nil)
    assert !table.save, 'Saved a new table with no database!'
  end

  # Test that the table should not save if there exists one with the same name on its database.
  def test_should_not_save_table_with_same_name
    database = Factory.create(:database)
    table = Factory.create(:table, :name => 'Same Name', :database => database)
    table2 = Factory.build(:table, :name => 'Same Name', :database => database)
    assert !table2.valid?, 'Saved a table with a duplicate name!'
  end

  # Test that a table will be deleted.
  def test_delete_table
    table = Factory.create(:table)
    assert table.destroy, 'Unable to destroy table'
  end

#destroy

  # Test that a table will be properly destroyed
	def test_destroy_table
		assert @tableA.destroy_table(@userA), 'User was unable to destroy table'
	end

  # Test that a general user cannot destroy someon else's database
	def test_destroy_someone_elses_table
		assert !@tableA.destroy_table(@userB), 'User could delete someone else\'s table'
	end

#edit
  # Test that you a general user could update their table
  def test_edit_own_table
    assert @tableA.edit_table(@userA), 'Could not update table'
  end

  # Test that a general user cannot edit anyone else's table
	def test_edit_someone_elses_table
    assert !@tableA.edit_table(@userB), 'User could update someone else\'s table'
  end

  # Test that an admin can edit any table
	def admin_can_edit_someone_elses_table
		assert @tableA.edit_table(@userAdmin), 'Admin could edit someone else\'s table'
	end

  # Test that a ta cannot edit anyone else's tables
	def ta_cant_edit_someone_elses_table
		assert !@tableA.edit_table(@userTA), 'TA could edit someone else\'s table'
	end

  # Test that a general user can edit their own table successfully
	def test_edit_own_table
		assert @tableA.update_attributes(:name => "new table"), 'Could not update table'
	end

#view
  # Test that a user can view their own table
	def test_view_own_table
    assert @tableA.view_table(@userA), 'Could not view table'
  end

  # Test that a general user cannot view anyone else's table
	def test_view_someone_elses_table
    assert !@tableA.view_table(@userB), 'User could view someone else\'s table'
  end

  # Test that an admin can view any table they want.
	def admin_can_view_someone_elses_table
		assert !@tableA.view_table(@userAdmin), 'Admin not could view someone else\'s table'
	end

  # Test that a ta can view someone else's table
	def ta_can_view_someone_elses_table
		assert @tableA.view_table(@userTA), 'TA could view someone else\'s table'
	end

  # TESTING SQL COMMANDS
  def test_add_sql_table
    database = Factory.create(:database)
    table = Factory.create(:table, :database => database)
    assert_equal "USE dbo." + database.name, database.use_dbsql, 'Did not generate valid SQL'

    assert_equal "CREATE TABLE " + tablename, table.create_dbsql, 'Did not generate valid SQL'
  end

  def test_alter_sql_table
    database = Factory.create(:database)
    table = Factory.create(:table, :database => database)
    column = Factory.create(:column, :table => table)
    assert_equal "USE dbo." + database.name, database.use_dbsql, 'Did not generate valid SQL'

    assert_equal "ALTER TABLE " + tablename, table.alter_dbsql, 'Did not generate valid SQL'
  end

  def test_drop_sql_table
    database = Factory.create(:database)
    table = Factory.create(:table, :database => database)
    column = Factory.create(:column, :table => table)
    assert_equal "USE dbo." + database.name, database.use_dbsql, 'Did not generate valid SQL'

    assert_equal "DROP TABLE " + tablename, table.drop_dbsql, 'Did not generate valid SQL'
  end
end
