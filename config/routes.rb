Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [ :show ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :urls, only: [ :create, :show, :destroy, :new ] do
    resources :visits, only: :index
    member do
      get "preview"
    end
  end

  get "/:short" => "urls#redirect", as: :redirect_url, constraints: { short: /t[A-Za-z0-9]{0,5}/ }
  get "/visits/search", to: "visits#search", as: :visits_search
  get "/visits/analytics", to: "visits#analytics"
  get "/urls/:url_id/visits/download", to: "visits#download", as: :url_visits_download

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "urls#new"
end
