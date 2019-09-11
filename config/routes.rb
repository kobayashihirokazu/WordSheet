Rails.application.routes.draw do
  # root to: 'users#index'
  resources :users
  
  root to: 'words#index'
  resources :words
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
