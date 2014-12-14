class TeamsController < ApplicationController
  before_action :login_required!
  before_action :no_team_required!, except: [:index, :show]
  before_action :set_team, only: [:show, :update]
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

  def update
    @team.users.push(current_user) # join this team
    session[:team_id] = @team.id # set it as the current_team
    flash[:notice] = "Successfully joined team. You are now a member of this team: #{@team.name}"
    redirect_to @team
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
  def set_team
    @team = Team.find(params[:id])
  end
  def no_team_required!
    if current_team # if current_user is not on a team yet
      flash[:alert] = "You are already on this team: #{current_team.name}."
      redirect_to root_path
    end
  end
end
