Rails.application.routes.draw do
  # devise_for :workers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :items
  resources :sessions, only: [:create, :destroy]
  resources :user_creation
end
