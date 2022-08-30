require 'rails_helper'
require_relative 'shared_file'

RSpec.describe 'RecipeFoods', type: :request do
  include_context 'request_context'

  let(:recipe) { Recipe.where(user_id: user.id).first }
  let(:food) { Food.last }

  describe 'action recipe_foods#create' do
    context 'with valid parameters' do
      let(:params) { { recipe_food: { recipe:, food:, quantity: 1 } } }

      before(:each) { post recipe_recipe_foods_path(recipe.id), params: }
      after(:each) { RecipeFood.where(recipe:, food:).destroy_all }

      it 'redirect to /foods' do
        expect(response).to redirect_to(recipe_path(recipe.id))
      end

      it 'Has correct placeholder text' do
        expect(response.body).to include(recipe_path(recipe.id))
      end
    end
  end

  describe 'action recipe_foods#destroy' do
    subject!(:recipe_food) { RecipeFood.create(recipe:, food:, quantity: 1) }

    before(:each) { delete recipe_recipe_food_path(recipe.id, food.id) }
    after(:each) { RecipeFood.where(recipe:, food:).destroy_all }

    it 'redirect to /foods' do
      expect(response).to redirect_to(recipe_path(recipe.id))
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include(recipe_path(recipe.id))
    end
  end

  describe 'action recipe_foods#update' do
    subject!(:recipe_food) { RecipeFood.create(recipe:, food:, quantity: 1) }
    let(:params) { { recipe_food: { recipe:, food:, quantity: 5 } } }

    before(:each) { put recipe_recipe_food_path(recipe.id, food.id), params: }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end
end
