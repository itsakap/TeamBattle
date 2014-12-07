class TeamCaptain::TeamsController < ApplicationController
  before_action :set_team
  before_action :team_captain_required!
  def show

  end
  private
  def set_team
    @team = Team.find(params[:id])
  end
  def team_captain_required!
    unless current_user.captain? && @team.id == current_user.team_id
      flash[:alert] = "You must be this team's team captain to do that."
      redirect_to root_path
    end
  end
end
