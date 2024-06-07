Rails.application.routes.draw do
  root "games#home"

  resources :games, only: [:show, :create, :update, :destroy, :index]
  get "/games/:id/over", to: "games#over", as: "over_game"
end
