Rails.application.routes.draw do
  
  root to: 'words#index'
  resources :users
  resources :words
    # resource :likes, only: [:create, :destroy]
  post "likes/:word_id/create", to: "likes#create"
  post "likes/:word_id/destroy", to: "likes#destroy"

  resources :relationships, only: [:create, :destroy]

  get "users/:id/likes", to: "users#likes"
  get "users/:id/followings", to: "users#followings"
  get "users/:id/followers", to: "users#followers"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
