class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new()
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
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
    @recipe = Recipe.find_by(params[:id])
  end

  def update
    @recipe = Recipe.find_by(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = 'the recipe was successfully updated'
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    @recipe = Recipe.find_by(params[:id])
    if @recipe.destroy
      flash[:success] = 'the recipe was successfully deleted'
      redirect_to recipes_path
    end
  end

  private
  def recipe_params
    params.require(:recipe).permit(:name, :description)
  end
end
