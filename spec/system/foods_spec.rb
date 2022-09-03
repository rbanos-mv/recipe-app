require 'rails_helper'
require_relative '../requests/shared_file'

RSpec.describe 'Foods', type: :feature do
  include_context 'request_context'

  describe 'foods#index page:' do
    before(:each) do
      visit foods_path
    end

    it 'shows the page header' do
      expect(page).to have_content('Food list')
    end

    it 'has the Add Food button' do
      expect(page).to have_selector(:link_or_button, 'Add Food')
    end

    it 'has a table' do
      expect(page).to have_table
    end

    it 'has some Delete links' do
      count = page.all(:link_or_button, 'Delete').count
      expect(count.positive?).to be(true)
    end

    context 'when clicking the Add Food button' do
      it 'it shows the foods#create page' do
        first(:link_or_button, 'Add Food').click

        expect(page).to have_current_path new_food_path
      end
    end
  end

  describe 'foods#new page:' do
    before(:each) do
      visit new_food_path
    end

    it 'shows the page header' do
      expect(page).to have_content('New Food')
    end

    context 'when form is filled' do
      before(:each) do
        fill_in 'food[name]', with: 'Roast Beef'
        fill_in 'food[measurement_unit]', with: 'kilo'
        fill_in 'food[price]', with: '1'
        fill_in 'food[quantity]', with: '2'
      end

      it 'it redirects to foods#index' do
        first(:link_or_button, 'Create Food').click

        expect(page).to have_current_path foods_path
      end

      it 'it adds a new food' do
        count_before = Food.where(user:).count
        first(:link_or_button, 'Create Food').click
        count_after = Food.where(user:).count

        expect(count_after).to eq(count_before + 1)
      end
    end
  end

  # ******************************************
  describe 'recipe_foods#new page:' do
    let(:recipe) { Recipe.where(user:).first }
    before(:each) do
      visit new_recipe_recipe_food_path(recipe.id)
    end
  end
end
