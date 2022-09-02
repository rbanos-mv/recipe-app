require 'rails_helper'
require_relative 'shared_file'

RSpec.describe 'Recipes', type: :request do
  include_context 'request_context'

  describe 'action recipes#create' do
    context 'with valid parameters' do
      let(:params) do
        { recipe: { user:, name: 'PASTA-ITALIANA', description: 'This is the description', preparation_time: '2 hours',
                    cooking_time: '30 minutes', public: true } }
      end

      before(:each) { post recipes_path params: }

      it 'redirect to /recipes' do
        expect(response).to redirect_to(recipes_path)
      end

      it 'has the name of the last inserted recipe' do
        last = Recipe.last
        expect(last.name).to eq(params[:recipe][:name])
      end

      it 'Has correct placeholder text' do
        expect(response.body).to include(recipes_path)
      end
    end
  end

  describe 'action recipes#destroy' do
    subject!(:recipe) do
      Recipe.create(user:, name: 'Arepa', description: 'this is a description', preparation_time: '1 hour',
                    cooking_time: '30 minutes', public: 1)
    end

    before(:each) { delete recipe_path(recipe) }

    it 'redirect to /recipes' do
      expect(response).to redirect_to(recipes_path)
    end

    it 'deletes the recipe' do
      expect(Recipe.where(id: recipe.id).exists?).to be(false)
    end
  end

  describe 'action recipes#index' do
    before(:each) { get recipes_path }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'render index template' do
      expect(response).to render_template('index')
    end

    it 'has the correct placeholder text' do
      expect(response.body).to include('Create new recipe')
    end
  end

  describe 'action recipes#show' do
    subject!(:recipe) do
      Recipe.create(user:, name: 'Arepa', description: 'this is a description', preparation_time: '1 hour',
                    cooking_time: '30 minutes', public: 1)
    end
    before(:each) { get recipe_path(recipe.id) }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'render show template' do
      expect(response).to render_template('show')
    end

    it 'has the correct placeholder text' do
      expect(response.body).to include('Preparation Time:')
    end
  end
end
