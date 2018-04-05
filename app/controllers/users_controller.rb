class UsersController < ApplicationController
  before_action :authenticate_user!

  def index    
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

     if @user.destroy
       flash[:notice] = "\"#{@user}\" was deleted successfully."
       redirect_to @user
     else
       flash.now[:alert] = "There was an error deleting the user."
       render :show
     end
  end
private


end
