Rails.application.routes.draw do
  resources :micro_posts
  resources :users
  root 'users#index'
end
