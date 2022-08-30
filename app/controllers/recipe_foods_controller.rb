class RecipeFoodsController < ApplicationController
  def create
    @recipe_food = RecipeFood.new(recipe_foods_params)
    # authorize! :create, @recipe_food
    if @recipe_food.save
      flash[:notice] = 'Food saved successfully'
    else
      flash[:alert] = 'Food not saved'
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  def destroy
    @recipe_food = RecipeFood.where(recipe_id: params[:recipe_id], food_id: params[:id]).first
    # authorize! :destroy, @recipe_food
    @recipe_food.destroy
    redirect_to recipe_path(params[:recipe_id])
  end

  def update
    # implement
  end

  private

  def recipe_foods_params
    params.require(:recipe_food).permit(:food_id, :quantity).merge(params.slice(:recipe_id).permit(:recipe_id))
  end
end
