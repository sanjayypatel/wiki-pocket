Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show] do
    post 'downgrade' => 'users#downgrade', as: :downgrade 
  end
  resources :wikis do 
      resources :collaborations, only: [:create, :destroy]
      resources :references, only: [:create, :destroy]
  end

  resources :links, except: [:index]

  resources :charges, only: [:new, :create]
  root to: 'welcome#index'
  get '/help', to: 'welcome#help'

  resources :tags, only: [:show, :index]

end
