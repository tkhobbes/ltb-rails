Rails.application.routes.draw do
  root "books#index"

  resources :books

  devise_for :users
end
