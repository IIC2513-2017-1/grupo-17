Rails.application.routes.draw do

  # Login, logout
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  root to: 'gees#index'

  resources :gees, only: [:new, :create, :index, :show] do
    resources :bets, only: [:new, :create, :index, :show]
  end

  # Edit, update, index and destroy method will be used only by administrators
  resources :users

  # Following methods will be used only by administrators
  resources :categories, only: [:index, :create, :destroy]
end
