class TeamCaptain::TeamsController < ApplicationController
  before_action :set_team
  before_action :login_required!
  before_action :team_captain_required!
  def show

  end

  def update
    if @team.update(team_params)
      flash[:notice] = "Team was updated"
    else
      flash[:alert] = "Team was not updated"
    end
    redirect_to team_captain_team_path(@team)
  end

  def remove_user_from_team
    user = User.find(params[:user_id])
    # if not trying to remove self and if user is on self's team
    if user.team_id == current_user.team_id && user.id != current_user.id  && !current_game

      @team.users.delete(user) # remove from team
      user.update(:game_id => nil)
      
      flash[:notice] = "Removed #{user.name} from team"
    else
      flash[:error] = "Sorry"
    end
    redirect_to team_captain_team_path(@team)
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end
  def team_params
    params.require(:team).permit(:name)
  end



end
