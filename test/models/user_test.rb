require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(username: 'testuser1', email: 'testuser@gmail.com', password: 'password', password_confirmation: 'password')
  end

  test "username should be present" do
    @user.username = ' '
    assert_not @user.valid?
  end
  
  test "user should be valid" do
    assert @user.valid?
  end
  
  test "chefname should be less than 30 characters" do
    @user.username = 'a' * 31
    assert_not @user.valid?
  end
  
  test "email should be present" do 
    @user.email = ' '
    assert_not @user.valid?
  end
  
  test "email shouldn't be too long" do
    @user.email = 'a' * 255 + '@gmail.com'
    assert_not @user.valid?
  end
  
  test 'email should accept correct format' do
    valid_email = %w[user@example.com JDFIJSEJIS@gmail.com dfje.hogeho@yahoo.dhjdk]
    valid_email.each do |valids|
      @user.email = valids
      assert @user.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test 'email should not accept incorrect format' do
    invalid_email = %w[user@example JDFIJSEJIS@gmail,com dfje.hogeho@yahoo.dhjdk. joe@bar+foo.ddd]
    invalid_email.each do |invalids|
      @user.email = invalids
      assert_not @user.valid?, "#{invalids.inspect} should be invalid"
    end
  end  
  
  test 'email should be unique and case insensitive' do 
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test 'email should be lower case before hitting db' do
    mixed_email = 'JoNhNNk@EjfJfm.Odm'
    @user.email = mixed_email
    @user.save
    assert_equal mixed_email.downcase, @user.reload.email 
  end
  
  test 'password should be present' do
    @user.password = @user.password_confirmation = ' '
    assert_not @user.valid?
  end
  
  test 'password should be at least 5 characters' do 
    @user.password = @user.password_confirmation = 'x' * 4
    assert_not @user.valid?
  end
 
  test 'associated recipes should be deleted' do
    @user.save
    @user.recipes.create!(name: 'testing destroy', description: 'testing destroy description')
    assert_difference 'Recipe.count', -1 do
      @user.destroy
    end
  end 
end
