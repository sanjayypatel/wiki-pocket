Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  resources :wikis

  root to: 'welcome#index'

end
