Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :restaurants, only: [:index, :show] do
    resources :dishes, only: [:index, :show]
    resources :tags, only: [:index, :show]
  end

  resources :dishes, only: [:index, :show] do
    resources :restaurants, only: [:index, :show]
  end

  resources :tags, only: [:index, :show] do
    resources :restaurants, only: [:index, :show]
  end

  post '/sign_up', to: 'user#create'

  post 'authenticate', to: 'authentication#authenticate'
  get 'profile', to: 'user#profile'
end
