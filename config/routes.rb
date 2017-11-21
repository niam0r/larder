Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :recipes do
    resources :quantities, only: [ :new, :create ]
    resources :favourites, only: [ :create ]
  end
  resources :quantities, only: [ :destroy ]
  resources :favourites, only: [ :destroy ]

  get 'dashboard', to: 'pages#dashboard'
end
