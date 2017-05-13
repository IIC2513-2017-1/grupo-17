Rails.application.routes.draw do

  root to: 'gees#index'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  resources :gees, only: [:new, :create, :index, :show] do
    resources :bets, only: [:new, :create, :index, :show]
  end

  # Edit, update, index and destroy method will be used only by administrators
  resources :users

  # Following methods will be used only by administrators
  resources :categories, only: [:index, :create, :destroy]
end
