Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :create, :show, :destroy, :update] do
    resources :dishes, only: [:index, :show]
    resources :deals, only: [:index, :show]
    resources :tags, only: [:index, :show]
    resources :reviews
  end

  resources :restaurant_requests, only: [:index, :create, :show, :destroy, :update] do
    post '/accept_request', to: 'restaurant_requests#accept_request'
  end

  resources :dishes, only: [:index, :show] do
    resources :restaurants, only: [:index, :show]
  end

  resources :deals, only: [:index, :show] do
    resources :restaurants, only: [:index, :show]
  end

  resources :tags, only: [:index, :show, :create] do
    resources :restaurants, only: [:index, :show]
  end

  resources :users, only: [:show, :index, :update, :create]

  post '/sign_up', to: 'users#sign_up'

  post 'authenticate', to: 'authentication#authenticate'
  get 'profile', to: 'users#profile'
end
