class RecipesController < ApplicationController
  before_action :authenticate_user!
  def index
    @recipes = Recipe.includes([:user]).where(user: current_user)
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
    values = params.permit(:name, :preparation_time, :cooking_time, :description, :public)
    if values[:public] == "1"
      @public = true
    else
      @public = false
    end
    @recipe = Recipe.new(user: current_user, name: values[:name], preparation_time: values[:preparation_time],
                         cooking_time: values[:cooking_time], description: values[:description], public: @public)

    if @recipe.save
      redirect_to recipes_path, notice: 'your post has been published successfully'
    else
      render :new
    end
  end
end
