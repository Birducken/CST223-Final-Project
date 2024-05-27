Rails.application.routes.draw do
  root "game#home"
  get "/play", to: "game#play"
end
