require 'rails_helper'
require_relative '../requests/shared_file'

RSpec.describe 'Homepages', type: :system do
  include_context 'request_context'

  describe 'index page:' do
    before(:each) do
      visit root_path
    end

    it 'shows the welcome message' do
      expect(page).to have_content('Welcome to our Recipe App')
    end

    context 'when clicking the menu option' do
      it 'Food list it shows the foods#index page' do
        first(:link, 'Food list').click

        expect(page).to have_current_path foods_path
      end

      #   it 'Recipe list it shows the recipes#index page' do
      #     first(:link, 'Recipe list').click
      #
      #     expect(page).to have_current_path recipes_path
      #   end

      it 'Shopping list it shows the home#shopping_list page' do
        first(:link, 'Shopping list').click

        expect(page).to have_current_path shopping_list_path
      end

      it 'Public Recipe list it shows the home#public_recipes page' do
        first(:link, 'Public Recipe list').click

        expect(page).to have_current_path public_recipes_path
      end
    end
  end

  describe 'shopping list:' do
    before(:each) do
      visit shopping_list_path
    end

    it 'shows the title' do
      expect(page).to have_content('Shopping List')
    end

    it 'shows the Amount of food to buy' do
      expect(page).to have_content('Amount of food to buy')
    end

    it 'shows the Total value of food needed' do
      expect(page).to have_content('Total value of food needed')
    end

    it 'has a table' do
      expect(page).to have_table
    end
  end

  describe 'Public Recipe list:' do
    before(:each) do
      visit public_recipes_path
    end

    context 'when click recipe name' do
      it 'redirects to recipe#show page' do
        @recipe = Recipe.where(public: true).first
        first(:link, @recipe.name).click

        expect(page).to have_current_path recipe_path(@recipe.id)
      end
    end
  end
end
