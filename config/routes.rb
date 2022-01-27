Rails.application.routes.draw do
  # GET /about
  get "about", to: "about#index" # to the AboutController and index action

  get "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"

  delete "logout", to: "session#destroy"

  root to: "main#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
