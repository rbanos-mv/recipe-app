class HomeController < ApplicationController
  # before_action :authenticate_user!
  # load_and_authorize_resource

  include HomeHelper

  def index
    # implement
  end

  def read
    p '==============================000'
    authorize! :read, current_user
  end

  def shopping_list
    @items, @total = calculate_shopping
  end
end
