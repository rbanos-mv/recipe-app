require 'rails_helper'
require_relative '../requests/shared_file'

RSpec.describe 'Recipes', type: :feature do
  include_context 'request_context'

  describe 'recipes#index page:' do
    before(:each) do
      visit recipes_path
    end

    it 'shows the page header' do
      expect(page).to have_content('Create new recipe')
    end

    context 'when click on Create new recipe button' do
      it 'shows the page header' do
        first(:link_or_button, 'Create new recipe').click

        expect(page).to have_current_path new_recipe_path
      end
    end

    context 'when click on recipe name' do
      it 'shows the page header' do
        @recipe = Recipe.where(user:).first
        click_link(@recipe.name)

        expect(page).to have_current_path recipe_path(@recipe.id)
      end
    end

    context 'when click on Remove button' do
      it 'removes one recipe' do
        count_before = Recipe.where(user:).count
        first(:link_or_button, 'Remove').click
        sleep 2
        count_after = Recipe.where(user:).count

        expect(count_after).to eq(count_before - 1)
      end
    end
  end

  describe 'recipes#new page:' do
    before(:each) do
      visit new_recipe_path
    end

    context 'when form is filled' do
      before(:each) do
        fill_in 'recipe_name', with: 'Pizzas'
        fill_in 'recipe_description', with: 'This is the description'
        fill_in 'recipe_preparation_time', with: '1 hour'
        fill_in 'recipe_cooking_time', with: '15 minutes'
        check 'recipe_public'
      end

      it 'it redirects to recipes#index' do
        first(:link_or_button, 'Save Recipe').click

        expect(page).to have_current_path recipes_path
      end
    end
  end

  describe 'recipe#show page:' do
    context 'when click button' do
      let(:recipe) { Recipe.where(user:).first }
      before(:each) do
        visit recipe_path(recipe.id)
      end

      it 'Generate shopping list it redirects to homepage#shopping_list' do
        first(:link_or_button, 'Generate shopping list').click

        expect(page).to have_current_path shopping_list_path
      end

      it 'Add new ingredient it redirects to homepage#shopping_list' do
        first(:link_or_button, 'Add new ingredient').click

        expect(page).to have_current_path new_recipe_recipe_food_path(recipe.id)
      end

      it 'Modify it redirects to homepage#shopping_list' do
        first(:link_or_button, 'Modify').click

        expect(page).to have_current_path edit_recipe_recipe_food_path(recipe.id, recipe.recipe_foods.first.id)
      end

      # it 'Remove removes one ingredient' do
      #   count_before = RecipeFood.where(recipe:).count
      #   first(:link_or_button, 'Remove').click
      #   sleep 2
      #   count_after = RecipeFood.where(recipe:).count

      #   expect(count_after).to eq(count_before - 1)
      # end
    end
  end
end
