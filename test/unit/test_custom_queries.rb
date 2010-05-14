require 'test/test_helper'

class DatabaseTest < ActiveSupport::TestCase
  
  def setup
    @userA = Factory.create(:user)
    @database = Factory.create(:database, :user => @userA)
  end
  
  def test_custom_sql_query_success
    query = "SELECT * FROM *"
    assert_equal true, @database.issue_query(@userA, query)
  end
  
  def test_custom_sql_query_fail
    query = ""
    assert_equal false, @database.issue_query(@userA, query)
  end
  
end
