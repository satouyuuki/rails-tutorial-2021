Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  # get 'static_pages/help'からget toを使うことで以下の名前付きルートが使えるようになる
  # help_path -> '/help'
  # help_url  -> 'http://www.example.com/help'
  get '/help', to: 'static_pages#help'

  get '/about', to: 'static_pages#about'

  get '/contact', to: 'static_pages#contact'

  root 'static_pages#home'
  post '/', to: 'microposts#create'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :update, :edit]
  resources :microposts, only: [:destroy]
end
