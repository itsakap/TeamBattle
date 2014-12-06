class SessionsController < ApplicationController
  def new
  
  end
  def create
    user = User.where(:name => params[:signin][:name]).first
    if user && user.authenticate(params[:signin][:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully signed in. Thanks."
      redirect_to root_url
    else
      flash[:error] = "Sorry."
      render :new
    end
  end
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Successfully signed out. See you soon!"
    
    redirect_to root_path
  end
end
