class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.friendly.find(params[:wiki_id])
    current_collaborators = @wiki.users
    @user = User.find_by(email: params[:collaborator][:user])
    authorize @collaborator
    
    if User.exists?(@user)
      if current_collaborators.include?(@user)
        flash[:error] = "#{@user.email} is already a collaborator. "
        redirect_to @wiki
      elsif @user == current_user
        flash[:error] = "You can not make yourself a collaborator. "
        redirect_to @wiki
      else
        @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)
        if @collaborator.save
          flash[:notice] = "\"#{@collaborator.user.email}\" was added successfully."
          redirect_to @wiki
        else
          flash.now[:alert] = "There was an error adding the Collaborator."
          render :show  
        end
      end
    else
      flash[:error] = "Sorry, no such user exists. "
      redirect_to @wiki
    end
  
  end

  def destroy
    @collaborator = Collaborator.find(params[:user_id])
    authorize @collaborator
    if @collaborator.delete
      redirect_to @collaborator
    else
      if @collaborator.save
        flash[:notice] = "\"#{@collaborator.user.email}\" was deleted successfully."
        redirect_to [@wiki]
      else
        flash.now[:alert] = "There was an error deleting the Wiki."
        render :show  
      end
    end
  end

end
