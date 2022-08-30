class FoodsController < ApplicationController
  before_action :authenticate_user!

  def create
    @food = Food.new(food_params)
    if @food.save
      flash[:notice] = 'Food saved successfully'
    else
      flash[:alert] = 'Food not saved'
    end
    redirect_to foods_path
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  def index
    @foods = Food.all
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
