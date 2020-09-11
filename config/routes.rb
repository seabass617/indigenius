Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  get 'user/show'

  get 'listings', to: 'items#listings'

  resources :reviews
  resources :reviews, only: %i[show destroy edit update]

  resources :items, except: :destroy do
    resources :workshop_dates, only: %i[index new create edit update destroy]
    resources :reviews, only: %i[index new create]
    resources :order_items, only: %i[create update]
  end
  resources :order_items, only: [:destroy]

  resources :orders, only: %i[index show]
  patch '/orders/:id', to: 'orders#confirm', as: 'confirm_order'
  put '/orders/:id', to: 'orders#cancell', as: 'cancell_order'

  delete '/items/:id', to: 'items#destroy', as: 'delete_item'
end
