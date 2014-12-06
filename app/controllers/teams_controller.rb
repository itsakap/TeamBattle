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
      flash[:notice]="Team created successfully."
      redirect_to root_path
    else
      flash[:alert]="Team was not created."
      redirect_to root_path
    end
  end

  def show
  end

  def update
    if current_user.team_id.nil?
      @team.users.push(current_user)
      flash[:notice] = "Successfully joined team. You are now a member of this team: #{@team.name}"
    else

      flash[:alert] = "You are already on this team: #{Team.find(current_user.team_id).name}."
    end
    redirect_to @team
  end

  private
  def team_params
    params.require(:team).permit(:name)
  end
  def set_team
    @team = Team.find(params[:id])
  end
end
