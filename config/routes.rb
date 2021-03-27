Rails.application.routes.draw do
  resources :rides
  resources :attractions do
    resources :rides
  end
  resources :users
  # get '/users/new', to: 'users#new', as: 'new_user'
  # get '/users', to:'users#index', as: 'users'
  # post '/users', to:'users#create'
  # get '/users/:id', to: 'users#show', as: 'user'
  # get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#home'

  # get 'signup', to: 'users#new'
  # post 'signup', to: 'users#create'

  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get '/auth/google_oauth2/callback', to: 'sessions#create'

  post 'signout', to: 'sessions#destroy'
end
