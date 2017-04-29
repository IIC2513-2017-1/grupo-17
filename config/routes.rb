Rails.application.routes.draw do

  root to: 'gees#index'

  resources :gees do
    resources :bets, only: [:new, :create, :index, :show]
  end
  resources :users

  # This resources will be used only by administrators
  resources :categories, only: [:index, :create, :destroy]
end
