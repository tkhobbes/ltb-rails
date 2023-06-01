Rails.application.routes.draw do
  root "books#index"

  resources :books
  resources :stories
  resources :artists

  devise_for :users
end
