TourMaven::Engine.routes.draw do
  resources :tours
  resources :events, only: :create
end
