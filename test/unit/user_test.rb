# Make sure we test DAVE

# Includes functions that allow Unit Testing
# Reference: http://guides.rubyonrails.org/testing.html
require 'test_helper'

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
end
