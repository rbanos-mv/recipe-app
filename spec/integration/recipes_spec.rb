require 'rails_helper'

RSpec.describe 'Recipe', type: :system do

  describe 'Visit recipes page' do
    context 'using capybara test' do
      it 'shows the static text' do
        visit('http://localhost:3000/recipes')
        fill_in('Email', with: 'rafael@mail.com')
        fill_in('Password', with: 'valido')
        click_button('Log in')
        sleep 3
        expect(page).to have_content('Create')
      end

      it 'create a new recipe' do
        visit('http://localhost:3000/recipes')
        fill_in('Email', with: 'rafael@mail.com')
        fill_in('Password', with: 'valido')
        click_button('Log in')
        sleep 3
        click_link('Create new recipe')
        sleep 1
        fill_in('recipe_name', with: 'Pasta')
        fill_in('recipe_preparation_time', with: '1 Hour')
        fill_in('recipe_cooking_time', with: '30 minutes')
        fill_in('recipe_description', with: 'Some pasta steps')
        click_button('Save Recipe')
        expect(page).to have_content('Pasta')
      end

      it 'Visit unique recipe and see the text' do
        visit('http://localhost:3000/recipes')
        fill_in('Email', with: 'rafael@mail.com')
        fill_in('Password', with: 'valido')
        click_button('Log in')
        sleep 3
        click_link('Recipe 11')
        expect(page).to have_content('Preparation Time')
      end

      it 'Visit unique recipe owner and click on add ingredients' do
        visit('http://localhost:3000/recipes')
        fill_in('Email', with: 'rafael@mail.com')
        fill_in('Password', with: 'valido')
        click_button('Log in')
        sleep 3
        click_link('Recipe 11')
        click_link('Add new ingredent')
        expect(page).to have_content('Add Food to Recipe')
      end

      it 'Visit unique recipe owner and click on generate shopping list' do
        visit('http://localhost:3000/recipes')
        fill_in('Email', with: 'rafael@mail.com')
        fill_in('Password', with: 'valido')
        click_button('Log in')
        sleep 3
        click_link('Recipe 11')
        click_link('Generate shopping list')
        expect(page).to have_content('Shopping List')
      end
    end
  end

  describe 'Visit public recipes page' do
    context 'using capybara test' do
      it 'Login and go to public recipes' do
        visit('http://localhost:3000/')
        click_link('Login')
        fill_in('Email', with: 'rafael@mail.com')
        fill_in('Password', with: 'valido')
        click_button('Log in')
        sleep 3
        visit('http://localhost:3000/public_recipes')
        expect(page).to have_content('Total food items')
      end
    end
  end
end