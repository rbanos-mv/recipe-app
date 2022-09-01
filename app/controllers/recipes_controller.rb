class RecipesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @recipes = Recipe.where(user: current_user)
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

  def create
    # values = params.permit(:name, :preparation_time, :cooking_time, :description, :public)
    # @public = values[:public] == '1'
    # @recipe = Recipe.new(user: current_user, name: values[:name], preparation_time: values[:preparation_time],
    #                      cooking_time: values[:cooking_time], description: values[:description], public: @public)
    if @recipe.save
      flash[:notice] = 'Recipe saved successfully'
    else
      flash[:alert] = 'Recipe not saved'
    end
    redirect_to recipes_path

    # if @recipe.save
    #   redirect_to recipes_path, notice: 'your recipe has been published successfully'
    # else
    #   render :new
    # end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :cooking_time, :preparation_time, :public)
      .merge({ user_id: current_user.id })
  end
end
