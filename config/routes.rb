Rails.application.routes.draw do
  root "books#index"

  resources :books
  resources :stories
  resources :artists
  resources :roles, only: %i[new create edit update destroy]

  devise_for :users
end
