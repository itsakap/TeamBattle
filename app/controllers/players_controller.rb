class PlayersController < ApplicationController
  before_action :set_player, only: [:show, :edit, :update, :destroy]
  def new
    @player = Player.new
  end
  
  def index
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      flash[:notice] = "You have signed up successfully."
      redirect_to root_path
    else
      flash[:alert] = "Player could not be created"
    end
  end

  private
  def player_params
    params.require(:player).permit(:email, :password, :password_confirmation, :hp, :attack_power, :heal_power)
  end
  def set_player
    @player = Player.find(params[:id])
  end
end
