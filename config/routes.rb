Rails.application.routes.draw do
  resources :order_items, only: [ :index, :new, :create, :edit, :update, :destroy ]
  devise_for :users
  root to: "pages#home"

  resources :workshop_dates, only: [ :create, :update, :destroy ]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items
  resources :orders, :only [:index]
  get '/myorders', to: 'orders#index'
end
