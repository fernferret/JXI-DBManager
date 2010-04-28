# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test/test_helper'

# Includes the functions that allow Mocking
# Reference: http://blog.floehopper.org/articles/2006/09/01/mocha-quickstart#fn1
# require 'mocha'

class UserTest < ActiveSupport::TestCase
  def test_add_all_criteria
#    Sample use of the factory
    user = Factory.create(:user)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
    assert user.save, 'Could not save a new User!'
  end

	def test_save_user_without_password
#    Sample use of the factory
    user = Factory.build(:user, :password => nil)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
    assert !user.valid?, 'Saved user without password'
  end

	def test_save_user_without_username
#    Sample use of the factory
    user = Factory.build(:user, :username => nil)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
    assert !user.valid?, 'Saved user without username'
  end

	def test_save_user_without_name
#    Sample use of the factory
    user = Factory.build(:user, :name => nil)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
    assert !user.valid?, 'Saved user without name'
	end 

	def test_user_has_email
#    Sample use of the factory
    user = Factory.build(:user)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
		user.email = "test@test.com"
    assert_match /.*@.*\..*/, user.email, 'User did not have a vaild email address' 
	end 

	def test_user_is_admin
#    Sample use of the factory
    user = Factory.build(:user)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
		user.permissions = "admin"
    assert_equals "admin", user.permissions, 'User was not an admin'
	end 

	def test_user_is_ta
#    Sample use of the factory
    user = Factory.build(:user)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
		user.permissions = "ta"
    assert_equals "ta", user.permissions, 'User was not a ta'
	end 

	def test_user_is_regular_user
#    Sample use of the factory
    user = Factory.build(:user)
#    user = User.new
#    user.username = "Username"
#    user.password = "Password"
#    user.name = "My Name"
    assert_equals "", user.permissions, 'User was not a regular user'
	end 
end
