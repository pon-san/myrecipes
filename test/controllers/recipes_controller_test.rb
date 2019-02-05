require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create!(username: "testuser", email: "test@example.com", password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: 'test name', description: 'test description1', user: @user)
    @recipe2 = Recipe.create(name: 'test name 2', description: 'test description2', user: @user)
  end
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
end
