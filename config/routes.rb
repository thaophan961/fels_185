Rails.application.routes.draw do
  get "static_pages/home"
  resources :categories, only: :index
end
