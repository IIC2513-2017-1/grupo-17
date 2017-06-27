Rails.application.routes.draw do

  root to: 'gees#index'

  get  '/login',  to: 'sessions#new',     as: 'login'
  post '/login',  to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy', as: 'logout'

  get    '/friends',                 to: 'friendships#list',           as: 'friends'
  get    '/friends/requests',        to: 'friendships#list_requests',  as: 'friend_requests'
  post   '/friends/:user_id',        to: 'friendships#send_request',   as: 'friend'
  post   '/friends/accept/:user_id', to: 'friendships#accept_request', as: 'friend_accept'
  delete '/friends/:user_id',        to: 'friendships#destroy'

  get '/notifications', to: 'notifications#index'

  get    '/gees/:id/invite',          to: 'gees#show_invite'
  post   '/gees/:id/invite/:user_id', to: 'gees#invite'
  delete '/gees/:id/invite/:user_id', to: 'gees#delete_member'
  get    '/gees/:id/close',           to: 'gees#close',         as: 'close_gee'

  resources :gees, only: [:new, :create, :index, :show, :update] do
    resources :bets, only: [:new, :create, :index, :show]
  end

  # Destroy method will be used only by administrators
  resources :users
  get 'users/confirmation/:token',   to: 'users#email_confirmation',   as: 'email_confirmation_user'

  # Following methods will be used only by administrators
  resources :categories, only: [:index, :create, :destroy]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show]
      resources :notifications, only: [:index]
      resources :gees, only: [:index, :show, :create] do
        resources :bets, only: [:index, :show, :create]
      end
      resources :categories, only: [:index]
    end
  end
end
