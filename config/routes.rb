Rails.application.routes.draw do
  root "books#index"

  resources :books
  resources :stories
  resources :artists
  resources :roles, only: %i[new create edit update destroy]

  resources :artist_scrapers, only: %i[new create]

  resources :inlays, only: %i[index show] do
    post :index, on: :collection
  end

  devise_for :users
end
