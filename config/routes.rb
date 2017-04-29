Rails.application.routes.draw do

  root to: 'gees#index'

  resources :gees do
    resources :bets, only: [:new, :create, :index, :show]
  end
  resources :users
  resources :categories, only: [:new, :create, :destroy]
end
