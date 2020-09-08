Rails.application.routes.draw do
  resources :order_items, only: [ :index, :new, :create, :edit, :update, :destroy ]
  devise_for :users
  root to: "pages#home"

  resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :orders, only: [:index]
  resources :items, except: :destroy do 
    resources :workshop_dates, only: [ :index, :new, :create, :edit, :update, :destroy ]
  end 
  delete '/items/:id', to: 'items#destroy', as: 'delete_item'
  get '/myorders', to: 'orders#index'
end
