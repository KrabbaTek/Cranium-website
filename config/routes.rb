Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"

  get "/thesis", to: "pages#thesis"

  get "/search", to: "packages#search", as: :search

  get "/login", to: "sessions#new", as: :login
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  get "/signup", to: "users#new", as: :signup
  post "/users", to: "users#create"

  get "/packages", to: "packages#new", as: :new_package
  post "/packages", to: "packages#create", as: :create_package

  get "/users/home", to: "users#home", as: :user_home

  get "/packages/user", to: "packages#show", as: :user_packages

  get "/packages/explore", to: "packages#index", as: :explore_packages

  scope "/api" do
    # TODO: this
  end
end
