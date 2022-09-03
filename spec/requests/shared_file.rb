shared_context 'request_context' do
  let!(:user) { User.order(:id).first }

  before(:all) do
    Rails.application.load_seed
  end

  before(:each) do
    login_as(user)
  end

  after(:each) do
    logout
  end

  after(:all) do
    RecipeFood.destroy_all
    Recipe.destroy_all
    Food.destroy_all
    User.destroy_all
  end
end
