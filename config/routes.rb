Rails.application.routes.draw do

  root to: 'gees#index'

  get  '/login',  to: 'sessions#new',     as: 'login'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy', as: 'logout'

  get    '/friends',                 to: 'friendships#list',           as: 'friends'
  post   '/friends/:user_id',        to: 'friendships#send_request',   as: 'friend'
  post   '/friends/accept/:user_id', to: 'friendships#accept_request', as: 'friend_accept'
  delete '/friends/:user_id',        to: 'friendships#destroy'

  get '/notifications', to: 'notifications#index'

  resources :gees, only: [:new, :create, :index, :show] do
    resources :bets, only: [:new, :create, :index, :show]
  end

  # Destroy method will be used only by administrators
  resources :users

  # Following methods will be used only by administrators
  resources :categories, only: [:index, :create, :destroy]
end
