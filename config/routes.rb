Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: 'home#index'
  get 'public_recipes', to: 'home#public_recipes'
  get 'shopping_list', to: 'home#shopping_list'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :foods, except: :update

  resources :recipes, except: :update do
    resources :recipe_foods, only: %i[create destroy edit new update]
  end
end
