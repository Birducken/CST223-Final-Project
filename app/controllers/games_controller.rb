class GamesController < ApplicationController
  def home
  end

  def show
    @game = Games.find(params[:id])
  end

  def create
    @game = Games.new
    @game.setup
    @game.save
    
    redirect_to @game
  end
end
