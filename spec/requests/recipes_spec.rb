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
end
