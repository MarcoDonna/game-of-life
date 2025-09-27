Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "games", to: "games#index", as: :games
  get "games/:id/show", to: "games#show", as: :show_game

  get "games/new", to: "games#new", as: :new_game
  post "games", to: "games#create", as: :create_game
  
  get "game_frames/:id/new", to: "game_frames#new", as: :new_game_frame
  get "game_frames/:id/show", to: "game_frames#show", as: :show_game_frame

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "games#index"
end
