Rails.application.routes.draw do
  resources :gees
  resources :fields
  resources :bets
  resources :categories
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
