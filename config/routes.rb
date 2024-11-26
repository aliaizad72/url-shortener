Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :urls, only: [ :create, :show ] do
    member do
      get "preview"
    end
  end

  get "/:short" => "urls#redirect", as: :redirect_url, constraints: { short: /t[A-Za-z0-9]{0,5}/ }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "/home", to: "pages#home"
  get "/analytics", to: "pages#analytics"
  get "/search", to: "pages#search"

  # Defines the root path route ("/")
  root "pages#home"
end
