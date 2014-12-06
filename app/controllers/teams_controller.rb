class TeamsController < ApplicationController
  before_action :login_required!
  def index
    @teams = Team.all
  end
  def new
    @team = Team.new
  end


  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.update(:captain? => true)
      flash[:notice]="Team created successfully."
      redirect_to root_path
    else
      flash[:alert]="Team was not created."
      redirect_to root_path
    end
  end
  private
  def team_params
    params.require(:team).permit(:name)
  end
end
