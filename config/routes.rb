Rails.application.routes.draw do
  root "games#home"

  resources :games, only: [:show, :create, :update, :destroy]
end
