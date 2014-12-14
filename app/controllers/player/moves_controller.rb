class Player::MovesController < ApplicationController
  before_action :set_move
  before_action :login_required!
  def edit
  end

  def update
    if @move.update(move_params)
      flash[:notice] = "Move was updated."
    else
      flash[:alert] = "Sorry"
    end
    redirect_to root_path
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
