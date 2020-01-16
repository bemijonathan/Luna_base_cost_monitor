Rails.application.routes.draw do
  resources :items
  post "sign_up" => 'user_creation#create'
  get "sign_out" => 'user_creation#destroy'
  post "login_in" => 'user_creation#login'
  get "workers" => "user_creation#all"
end
