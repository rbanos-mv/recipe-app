class RecipesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @recipes = Recipe.includes([:user]).where(user: current_user)
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_foods = RecipeFood.includes([:food]).includes([:recipe]).where(recipe_id: params[:id])
  end

  def destroy
    @recipes = Recipe.find(params[:id])

    @recipes.destroy
    redirect_to recipes_path
  end

  def create
    if @recipe.save
      flash[:notice] = 'Recipe saved successfully'
    else
      flash[:alert] = 'Recipe not saved'
    end
    redirect_to recipes_path
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
      .merge({ user_id: current_user.id })
  end
end
