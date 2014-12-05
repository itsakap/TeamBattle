class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def new
    @user = User.new
  end
  
  def index
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have signed up successfully."
      redirect_to root_path
    else
      flash[:alert] = "Player could not be created."
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :x, :y, :z)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
