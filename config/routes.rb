Rails.application.routes.draw do
  root "books#index"

  resources :books, only: %i[index]

  devise_for :users
end
