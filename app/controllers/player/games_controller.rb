# player/games_controller.rb
class Player::GamesController < ApplicationController
  before_action :login_required!
  before_action :game_started!
  # this action returns an object containing all of the legal targets given move choice
  def target_team_users
    targets = {current_target:current_user.move.target}
    move_type = params[:move_choice]
    if move_type == "attack"
      targets['legal_targets'] = current_game.users.alive - current_team.users.alive
    elsif move_type == "heal"
      targets['legal_targets'] = current_team.users.alive
    else
      targets['legal_targets'] = []
    end
    render json: targets
      
  end
end