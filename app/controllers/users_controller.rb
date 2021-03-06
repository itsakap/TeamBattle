class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def index
    # root
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have signed up successfully."
      redirect_to root_path
    else
      flash[:alert] = "Player could not be created."
      render :new
    end
  end

  private
  def user_params
    params[:user][:x] = 0 if params[:user][:x] == ""
    params[:user][:y] = 0 if params[:user][:y] == ""
    params[:user][:z] = 0 if params[:user][:z] == ""
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :x, :y, :z)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
