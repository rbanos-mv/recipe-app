class FoodsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    if @food.save
      flash[:notice] = 'Food saved successfully'
    else
      flash[:alert] = 'Food not saved'
    end
    redirect_to foods_path
  end

  def destroy
    @food.destroy
    flash.now[:notice] = 'Food was deleted!'
    redirect_to foods_path
  rescue ActiveRecord::InvalidForeignKey
    flash.now[:alert] = 'Food cannot be deleted!'
    redirect_to foods_path
  end

  def index
    @foods = Food.where(user: current_user)
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
      .merge({ user_id: current_user.id })
  end
end
