class RecipesController < ApplicationController
  def index
    @recipes = Recipe.includes([:user]).where(user: params[:user_id])
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.includes([:food]).where(recipe_id: params[:id])
  end

  def destroy
    @recipes = Recipe.find(params[:id])

    @recipes.destroy
    redirect_to recipes_path
  end

  def edit
    if self.public
      self.public = false
    else
      self.public = true
    end
  end
end
