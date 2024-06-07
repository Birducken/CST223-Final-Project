class GamesController < ApplicationController
  def home
  end

  def show
    @game = Games.find(params[:id])

    if params.key?(:message)
      @message = params[:message]
    else
      @message = "Curator"
    end
  end

  def index
    if Games.exists?(params[:id])
      redirect_to game_path(params[:id])
    else
      redirect_to root_path
    end
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
    else
      message = "Invalid Transaction"
    end

    if @game.game_state == :in_progress 
      redirect_to game_path(@game, message: message)
    else
      redirect_to over_game_path(@game)
    end
  end

  def destroy
    @game = Games.find(params[:id])
    @game.destroy

    redirect_to root_path, status: :see_other
  end

  def over
    @game = Games.find(params[:id])

    if @game.game_state == :in_progress
      redirect_to @game
    else
      case @game.game_state
      when :won
        @message = "Victory"
      when :lost_frozen
        @message = "Defeat: No Valid Transactions"
      when :lost_overflow
        @message = "Defeat: Private Sales Overflow"
      end

      @game.destroy
    end
  end

  private
  
  def convert_params
    if params.key?(:bought)
      params[:bought] = params[:bought].to_i
    end
    if params.key?(:sold)
      params[:sold] = params[:sold].map { |index| index.to_i }
    end
  end
end
