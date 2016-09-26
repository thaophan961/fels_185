Rails.application.routes.draw do

  root "static_pages#home"
  get "sign_up" => "registers#new"
  resources :users
  resources :registers, only: [:new, :create]
  resources :categories, only: :index
  resources :words, only: :index
end
