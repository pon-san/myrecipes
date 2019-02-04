require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(username: 'testuser1', email: 'testuser@gmail.com')
  end

  test "username should be present" do
    @user.username = ' '
    assert_not @user.valid?
  end
end
