Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  resources :wikis
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'

end
