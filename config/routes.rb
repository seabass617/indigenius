Rails.application.routes.draw do

  devise_for :users
  root to: "pages#home"

  get 'listings', to: 'items#listings'

  resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :reviews, only: [:show, :destroy, :edit, :update]
  resources :orders, only: [:index, :show]

  resources :items, except: :destroy do 
    resources :workshop_dates, only: [ :index, :new, :create, :edit, :update, :destroy ]
    resources :reviews, only: [:index, :new, :create]
    resources :order_items, only: [ :create, :update ]
  end

  resources :order_items, only: [ :destroy ]

  patch '/orders/:id', to: 'orders#confirm', as: 'confirm_order'
  put '/orders/:id', to: 'orders#cancell', as: 'cancell_order'

  delete '/items/:id', to: 'items#destroy', as: 'delete_item'
end
