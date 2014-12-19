class SessionsController < ApplicationController
  def new
  
  end
  def create
    user = User.where(:name => params[:signin][:name]).first
    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      session[:team_id] = user.team_id
      flash[:notice] = "Successfully signed in. Thanks."
      redirect_to root_url
    else
      flash[:error] = "Invalid Login Info."
      render :new
    end
  end
  def destroy
    session[:user_id] = nil
    session[:team_id] = nil
    flash[:notice] = "Successfully signed out. See you soon!"
    
    redirect_to root_path
  end
end
