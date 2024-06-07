class GamesController < ApplicationController
  def home
  end

  def show
    @game = Games.find(params[:id])
    logger.debug @game.game_state
  end

  def create
    @game = Games.new
    @game.setup
    @game.save
    
    redirect_to @game
  end

  def update
    @game = Games.find(params[:id])
    convert_params
  
    if @game.valid_transaction? params[:bought], params[:sold]
      @game.perform_transaction params[:bought], params[:sold]
      @game.save
    end

    redirect_to @game
  end

  private
  
  def convert_params
    params[:bought] = params[:bought].to_i
    params[:sold] = params[:sold].map { |index| index.to_i }
  end
end
