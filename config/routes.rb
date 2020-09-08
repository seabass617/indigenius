Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :workshop_dates, only: [ :create, :update, :destroy ]
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :reviews, only: [:show, :destroy, :edit, :update]
  resources :orders, only: [:index]
  get '/myorders', to: 'orders#index'
end
