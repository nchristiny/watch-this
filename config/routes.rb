require 'api_constraints'

Rails.application.routes.draw do
  namespace :api, defaults:  { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true)  do
      root 'films#index'
      get    'signup'  => 'users#new'
      get    'login'   => 'sessions#new'
      post   'login'   => 'sessions#create'
      delete 'logout'  => 'sessions#destroy'
      resources :films, only: [:index, :show]
      resources :users, only: [:show, :index, :create, :update, :destroy]
      resources :recommendations, only: [:new, :index, :show, :create, :destroy]
    end
  end
end
