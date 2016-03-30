Rails.application.routes.draw do

  root              to: "static_pages#home"
  get    "about",   to: "static_pages#about"

  devise_for :users

  get    "login",   to: "sessions#new"
  post   "login",   to: "sessions#create"
  get    "logout",  to: "sessions#destroy"
  delete "logout",  to: "sessions#destroy"

  resources :users, param: :name

end
