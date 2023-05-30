Rails.application.routes.draw do
  root "books#index"

  resources :books
  resources :stories

  devise_for :users
end
