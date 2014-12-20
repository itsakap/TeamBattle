class TeamsController < ApplicationController
  before_action :login_required!
  before_action :set_team, only: [:show, :update]
  before_action :no_team_required!, except: [:index, :show]
  def index
    @teams = Team.available
  end
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.update(:captain? => true)
      @team.users.push(current_user)
      session[:team_id] = @team.id
      flash[:notice]="Team created successfully."
    else
      flash[:alert]="Team was not created."
    end
    redirect_to root_path 
  end

  def show

  end

  def update # for joining a team; could have been replicated in a join model.
    @team.users.push(current_user) # join this team
    session[:team_id] = @team.id # set it as the current_team
    current_user.update(:game_id => @team.game_id)
    flash[:notice] = "Successfully joined team. You are now a member of this team: #{@team.name}"
    redirect_to @team
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
  def set_team
    @team = Team.find(params[:id])
    if @team.started? && @team.id != current_team.id
      flash[:alert] = "This team currently has a game in progress."
      redirect_to teams_path
    end
  end
  def no_team_required!
    if current_team # if current_user is not on a team yet
      flash[:alert] = "You are already on this team: #{current_team.name}."
      redirect_to root_path
    end
  end

end
