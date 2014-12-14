class TeamsController < ApplicationController
  before_action :login_required!
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
      flash[:notice]="Team created successfully."
    else
      flash[:alert]="Team was not created."
    end
    redirect_to root_path 
  end

  def show
  end

  def update
    if current_user.team_id.nil? # if current_user is not on a team yet
      @team.users.push(current_user) # join this team
      session[:team_id] = @team.id # set it as the current_team
      flash[:notice] = "Successfully joined team. You are now a member of this team: #{@team.name}"
      redirect_to @team
    else
      flash[:alert] = "You are already on this team: #{Team.find(current_user.team_id).name}."
      redirect_to '/'
    end
    
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
  def set_team
    @team = Team.find(params[:id])
  end
end
