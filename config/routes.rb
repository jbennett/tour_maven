TourMaven::Engine.routes.draw do
  resources :tours
  resources :events, only: :create

  root to: "dashboards#show"
end
