Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show, :destroy] do
    resources :dishes, only: [:index, :show]
    resources :tags, only: [:index, :show]
    resources :reviews
  end

  resources :dishes, only: [:index, :show] do
    resources :restaurants, only: [:index, :show]
  end

  resources :tags, only: [:index, :show] do
    resources :restaurants, only: [:index, :show]
  end

  get '/user/:id', to: 'user#show'

  post '/sign_up', to: 'user#create'

  post 'authenticate', to: 'authentication#authenticate'
  get 'profile', to: 'user#profile'
end
