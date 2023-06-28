Rails.application.routes.draw do
  root "books#index"

  resources :books
  resources :stories
  resources :artists
  resources :roles, only: %i[new create edit update destroy]

  resources :book_searches, only: %i[new create]

  resources :artist_scrapers, only: %i[new create]
  resources :artist_portraits, only: :create
  resources :story_scrapers, only: %i[new create]
  resources :story_covers, only: :create
  resources :role_scrapers, only: :create
  resources :book_scrapers, only: %i[new create]
  resources :book_covers, only: :create
  resources :book_stories_scrapers, only: :create

  resources :inlays, only: %i[index show] do
    post :index, on: :collection
  end

  devise_for :users
end
