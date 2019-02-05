class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_user_like, only: [:like]

  def index
    @recipes = Recipe.all
    @recipes = Recipe.page(params[:page]).per(10)
  end

  def new
    @recipe = Recipe.new()
  end

  def show
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:success] = 'Recipe was created successfully!'
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end

  def edit 
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = 'the recipe was successfully updated'
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    if @recipe.destroy
      flash[:success] = 'the recipe was successfully deleted'
      redirect_to recipes_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :image, ingredient_ids: [])
  end
  
  def require_same_user
    if current_user != @recipe.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own recipes"
      redirect_to recipes_path
    end  
  end
end
