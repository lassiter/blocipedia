# Wikis Controller
class WikisController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index    
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def create
    @wiki = Wiki.new(wiki_params)
    @wiki.user = current_user

    if @wiki.save
      flash[:notice] = "Wiki was saved."
      redirect_to [@wiki]
    else
      flash.now[:alert] = "There was an error saving the Wiki. Please try again."
      render :new  
    end
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    @wiki.assign_attributes(wiki_params)
    authorize @wiki
    if @wiki.update(wiki_params)
      redirect_to @wiki
    else
      if @wiki.save
        flash[:notice] = "Wiki was saved."
        redirect_to [@wiki]
      else
        flash.now[:alert] = "There was an error saving the Wiki. Please try again."
        render :new  
      end
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    if @wiki.delete
      redirect_to @wiki
    else
      if @wiki.save
        flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
        redirect_to [@wiki]
      else
        flash.now[:alert] = "There was an error deleting the Wiki."
        render :show  
      end
    end
  end
private
  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end


end
