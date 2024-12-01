Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  get "/favicon.ico", to: ->(_) { [ 204, {}, [] ] }

  root "tickets#index"

  # User signup
  get "signup", to: "users#new"
  post "signup", to: "users#create"

  # Login/logout
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  post "logout", to: "sessions#destroy", as: :logout

  resources :tickets do
    resources :line_items, except: [ :index, :show ]
    member do
      get :invoice
    end
  end

  resources :customers
end
