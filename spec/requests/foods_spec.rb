require 'rails_helper'
require_relative 'shared_file'

RSpec.describe 'Foods', type: :request do
  include_context 'request_context'

  describe 'action foods#create' do
    context 'with valid parameters' do
      let(:params) { { food: { user:, name: 'peanuts', measurement_unit: 'grams', price: 1, quantity: 1 } } }

      before(:each) { post foods_path params: }

      it 'redirect to /foods' do
        expect(response).to redirect_to(foods_path)
      end

      it 'has the name of the last inserted food' do
        last = Food.last
        expect(last.name).to eq(params[:food][:name])
      end

      it 'Has correct placeholder text' do
        expect(response.body).to include(foods_path)
      end
    end
  end

  describe 'action foods#destroy' do
    subject!(:food) { Food.create(user:, name: 'peanuts', measurement_unit: 'grams', price: 1, quantity: 1) }

    before(:each) { delete food_path(food) }

    it 'redirect to /foods' do
      expect(response).to redirect_to(foods_path)
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include(foods_path)
    end
  end

  describe 'action foods#index' do
    before(:each) { get foods_path }

    it 'returns http_success' do
      expect(response).to have_http_status(:success)
    end

    it 'Renders index template' do
      expect(response).to render_template('index')
    end

    it 'Has correct placeholder text' do
      expect(response.body).to include('<h1>Food list</h1>')
    end
  end
end
