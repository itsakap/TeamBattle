# games_controller.rb
class TeamCaptain::GamesController < ApplicationController
  before_action :set_team
  before_action :team_captain_required!
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:notice] = "Game was successfully created"
    else
      flash[:alert] = "Game was not created"
    end
    redirect_to root_path
  end

  private

  def set_team
    @team = Team.find(current_user.team_id)
  end
  
  def game_params
    params.require(:game).permit(:name)
  end
end