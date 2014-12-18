class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
private
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_team
  def current_team
    @current_team ||= Team.find(session[:team_id]) if session[:team_id]
  end
  helper_method :current_game
  def current_game
    if current_team
      @current_game ||= Game.find(current_team.game_id) if current_team.game_id
    end
  end
  helper_method :login_required!
  def login_required!
    if current_user.nil?
      flash[:error] = "You need to sign in or sign up before continuing"
      redirect_to sign_in_path
    end
  end
  helper_method :team_captain_required!
  def team_captain_required!
    unless current_user.captain? && @team.id == current_user.team_id
      flash[:alert] = "You must be this team's team captain to continue."
      redirect_to root_path
    end
  end
  helper_method :game_started!
  def game_started!
    if current_game
      unless current_game.started?
        flash[:alert] = "Please wait for the game to start before continuing."
        redirect_to root_path
      end
    else
        flash[:alert] = "Your team is not in a game yet!"
        redirect_to root_path
    end
  end
end