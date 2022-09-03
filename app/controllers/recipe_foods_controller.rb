class RecipeFoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe_food, only: %i[show edit update destroy]
  load_and_authorize_resource

  def create
    if @recipe_food.save
      flash[:notice] = 'RecipeFood saved successfully'
    else
      flash[:alert] = 'RecipeFood not saved'
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  def destroy
    @recipe_food.recipe_id = nil
    @recipe_food.food_id = nil
    @recipe_food.destroy

    redirect_to request.path
  end

  def new
    @foods = Food.where(user: current_user)
  end

  def edit
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food.quantity = recipe_food_params[:quantity]
    @recipe_food.save
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def set_recipe_food
    @recipe_food = RecipeFood.where(recipe_id: params[:recipe_id], food_id: params[:id]).first
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:food_id, :quantity).merge(params.slice(:recipe_id).permit(:recipe_id))
  end
end
