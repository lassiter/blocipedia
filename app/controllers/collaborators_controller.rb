class CollaboratorsController < ApplicationController
include CollaboratorsHelper
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:collaborators][:email])
    @collaborator = Collaborator.new(wiki: @wiki, user: @user)

    if @user == nil
      flash[:alert] = "Sorry, no such user exists. "
      redirect_to @wiki
    elsif User.exists?(@user.id)
      if @current_user == @collaborator.user
        flash[:alert] = "#{@user.email} is already a collaborator. "
        redirect_to @wiki
      elsif @user == current_user
        flash[:alert] = "You can not make yourself a collaborator. "
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
      flash[:alert] = "Sorry, no such user exists. "
      redirect_to @wiki
    end
  
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    owner = Wiki.find(@collaborator.wiki_id).user
    if @collaborator.delete
      if current_user == owner || current_user.admin?
        redirect_to wiki_path(@collaborator.wiki_id)
      else
        redirect_to wikis_path
      end
    else
      if @collaborator.save
        flash[:notice] = "\"#{@collaborator.user.email}\" was deleted successfully."
        redirect_to wiki_path(@collaborator.wiki_id)
      else
        flash.now[:alert] = "There was an error deleting the Collaborator."
        redirect_to wiki_path(@collaborator.wiki_id)  
      end
    end
  end

end
