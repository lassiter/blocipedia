class CollaboratorsController < ApplicationController
include CollaboratorsHelper
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by(email: params[:collaborators][:email])
    @collaborator = Collaborator.new(wiki: @wiki, user: @user)
    authorize @collaborator

    if @collaborator.save
      redirect_to @wiki
    else
      render :show
    end
    # if @user == nil
    #   flash[:alert] = "Sorry, no such user exists. "
    #   redirect_to @wiki
    # elsif User.exists?(@user.id)
    #   if is_a_current_collaborator?(@wiki)
    #     flash[:alert] = "#{@user.email} is already a collaborator. "
    #     redirect_to @wiki
    #   elsif @user == current_user
    #     flash[:alert] = "You can not make yourself a collaborator. "
    #     redirect_to @wiki
    #   else
    #     @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)
    #     if @collaborator.save
    #       flash[:notice] = "\"#{@collaborator.user.email}\" was added successfully."
    #       redirect_to @wiki
    #     else
    #       flash.now[:alert] = "There was an error adding the Collaborator."
    #       render :show  
    #     end
    #   end
    # else
    #   flash[:alert] = "Sorry, no such user exists. "
    #   redirect_to @wiki
    # end
  
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    owner = Wiki.find(@collaborator.wiki_id).user
    authorize @collaborator
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
  public
  # def is_a_current_collaborator?
  #   @current_collaborators = @current_collaborators.as_json
  #   @current_collaborators.each do |key|
  #     collaborator_user_id = key.dig("user_id")
  #     break true if @user.id == collaborator_user_id
  #   end
  # end

end
