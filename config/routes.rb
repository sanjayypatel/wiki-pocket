Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update] do
    post 'upgrade' => 'users#upgrade', as: :upgrade
    post 'downgrade' => 'users#downgrade', as: :downgrade
  end
  resources :wikis
  resources :charges, only: [:new, :create]
  root to: 'welcome#index'

end
