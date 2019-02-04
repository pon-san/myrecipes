require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @recipe = Recipe.create(name: 'test name', description: 'test description1')
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
end
