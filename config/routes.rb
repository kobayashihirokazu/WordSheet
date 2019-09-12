Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # root to: 'users#index'
  resources :users
  
  root to: 'words#top'
  resources :words
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
