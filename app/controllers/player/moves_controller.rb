# player/moves_controller.rb
class Player::MovesController < ApplicationController
  before_action :set_move
  before_action :login_required!
  before_action :game_started!
  def edit
  end

  def update
    if current_user.eliminated?
      flash[:alert] = "Sorry, you have been eliminated."
      redirect_to root_path
    end
    if @move.update(move_params)
      flash[:notice] = "Move was updated. Check back tomorrow for updates in your game."
    else
      flash[:alert] = "Sorry"
    end
    redirect_to player_move_path
  end

  private
  def move_params
    # sanitize target by casting its value to an integer
    params[:move][:target]= params[:move][:target].to_i
    # this will allow a lookup of user id when move is validated
    params.require(:move).permit(:move_choice, :target)
  end
  def set_move
    @move = current_user.move
  end
end
