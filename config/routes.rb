Rails.application.routes.draw do
  
  root to: 'words#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resource :relationships, only: [:create, :destroy]
    member do
      get :likes
      get :followings
      get :followers
    end
  end

  resources :words do
    resource :likes, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
