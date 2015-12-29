Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update, :show] do
    post 'downgrade' => 'users#downgrade', as: :downgrade 
  end
  resources :wikis do 
      resources :collaborations, only: [:create, :destroy]
      resources :references, only: [:create, :destroy]
  end
  get 'wikis/create_wiki_from_link/:link_id' => 'wikis#create_wiki_from_link', :as => 'create_wiki_from_link'

  resources :links
  post 'create_link_with_wiki' => "links#create_link_with_wiki", :as => "create_link_with_wiki"

  resources :charges, only: [:new, :create]
  root to: 'welcome#index'
  get '/help', to: 'welcome#help'

  resources :tags, only: [:show, :index]

  get "connect" => "links#connect_to_pocket", :as => "connect_to_pocket"
  get "authorize_callback" => "links#authorize_callback", :as => "authorize_callback"

end
