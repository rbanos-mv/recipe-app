require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before do
    @user = User.new(name: 'Rafael', email: 'rega1237@mail.com')
    @user.password = 'valido'
    @user.password_confirmation = 'valido'
    @user.confirm
    login_as(@user)
    @recipe = Recipe.create(name: 'Pizza', preparation_time: '1 Hour', cooking_time: '1.5 Hours',
                            description: 'Lorem ipsum dolor sit amet', user: @user, public: false)
  end

  context 'When testing the Recipe class' do
    it 'should contain an user' do
      expect(@recipe.user).to eq(@user)
    end

    it 'should contain a recipe name' do
      expect(@recipe.name).to eq('Pizza')
    end

    it 'should contain preparation time' do
      expect(@recipe.preparation_time).to eq('1 Hour')
    end

    it 'should contain cooking time' do
      expect(@recipe.cooking_time).to eq('1.5 Hours')
    end

    it 'should contain a description' do
      expect(@recipe.description).to eq('Lorem ipsum dolor sit amet')
    end

    context 'When testing Validations' do
      it 'should validate that name recipe isn\'t empty' do
        @recipe.name = nil
        expect(@recipe).not_to be_valid
      end

      it 'should validate preparation time isn\'t empty' do
        @recipe.preparation_time = nil
        expect(@recipe).not_to be_valid
      end

      it 'should validate cooking time isn\'t empty' do
        @recipe.cooking_time = nil
        expect(@recipe).not_to be_valid
      end

      it 'should validate description isn\'t empty' do
        @recipe.description = nil
        expect(@recipe).not_to be_valid
      end
    end
  end
end
