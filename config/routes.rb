Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"

  get "/thesis", to: "pages#thesis"
  get "/tutorial", to: "pages#tutorial"

  resource :session, only: %i[ new create destroy ]

  resources :users, only: %i[ new create ]
  get "/users/home", to: "users#home", as: :user_home

  resources :packages, only: %i[ index new create show ] do
    collection do
      get :search
    end
  end

  # show all packages for a user
  resources :users, only: [] do
    resources :packages, only: %i[ index ]
  end

  # routes for the CLI
  namespace :api do
    # install
    get "/install/:name", to: "packages#install"

    # omakase
    get "/omakase", to: "packages#omakase"

    # random
    get "/packages/random", to: "packages#random"

    # clone
    get "/packages/clone/:name", to: "packages#clone_library"

    # search
    get "/packages/search/:name", to: "packages#search"
  end
end
