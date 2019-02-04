require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
end
