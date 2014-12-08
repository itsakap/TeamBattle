class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
private
  # current_user helper method
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def login_required!
    if current_user.nil?
      flash[:error] = "You need to sign in or sign up before continuing"
      redirect_to sign_in_path
    end
  end
  helper_method :login_required!

  def team_captain_required!
    unless current_user.captain? && @team.id == current_user.team_id
      flash[:alert] = "You must be this team's team captain to do that."
      redirect_to root_path
    end
  end
  helper_method :team_captain_required!

end
