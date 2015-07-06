Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show] do
    post 'downgrade' => 'users#downgrade', as: :downgrade 
  end
  resources :wikis do 
      resources :collaborations, only: [:create, :destroy]
  end
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'

end
