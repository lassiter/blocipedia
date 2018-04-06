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
  def downgrade
    @user = User.find(params[:id])
    @wikis = current_user.wikis
    puts "@user: #{@user.inspect} ---- current_user: #{current_user.inspect}"
    if @user == current_user
      @wikis.update_all(private: false)
      current_user.update_attribute(:role, 'member').save

      flash[:notice] = "#{current_user.email} you're account has been downgraded"
      redirect_to user_path
    end
  end
private


end
