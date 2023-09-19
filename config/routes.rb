require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

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
  resources :holistic_scrapers, only: :create

  resources :inlays, only: %i[index] do
    post :index, on: :collection
    post :print, to: 'inlays#print', on: :collection
  end

  resources :notifications, only: %i[index] do
    post :read, to: 'notifications#read', on: :member
    delete :read, to: 'notifications#unread', on: :member
  end

  devise_for :users
end
