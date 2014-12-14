# player/games_controller.rb
class Player::GamesController < ApplicationController
  before_action :login_required!
  before_action :game_started!
  def target_team_users
    move_type = params[:move_choice]
    if move_type == "Attack"
      targets = current_game.users - current_team.users
    elsif move_type == "Heal"
      targets = current_team.users
    else
      targets = []
    end
    render json: targets
      
  end
end