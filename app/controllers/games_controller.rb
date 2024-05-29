class GamesController < ApplicationController
  def home
  end

  def show
  end

  def create
    @game = Games.new
    logger.info @game.save
    redirect_to @game
  end
end
