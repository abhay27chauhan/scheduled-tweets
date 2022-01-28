Rails.application.routes.draw do
  # GET /about
  get "about", to: "about#index" # to the AboutController and index action

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  delete "logout", to: "sessions#destroy"

  get "edit_password", to: "password#edit"
  patch "edit_password", to: "password#update"

  get "password/reset", to: "password_reset#new"
  post "password/reset", to: "password_reset#create"
  get "password/reset/edit", to: "password_reset#edit"
  patch "password/reset/edit", to: "password_reset#update"

  root to: "main#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
