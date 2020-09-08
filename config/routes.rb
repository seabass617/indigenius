Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :workshop_dates, only: [ :create, :update, :destroy ]
  resources :reviews
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items, except: :destroy
  delete '/items/:id', to: 'items#destroy', as: 'delete_item'

  #resources :orders, :only [:index]
  get '/myorders', to: 'orders#index'
end
