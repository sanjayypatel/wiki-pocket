Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update] do
    post 'downgrade' => 'users#downgrade', as: :downgrade 
  end
  resources :wikis
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'
  get '/help', to: 'welcome#help'

end
