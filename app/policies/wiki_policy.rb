class WikiPolicy < ApplicationPolicy
include CollaboratorsHelper
  def initialize(current_user, model) #mentor
    @current_user = current_user
    @wiki = model #mentor
  end

  def index?
    @current_user
  end
  def create?
    @current_user
  end

  def update?
    if @wiki.private?
      @current_user.id == @wiki.user_id || is_a_current_collaborator?(@wiki)
    else
      @current_user
    end
  end

  def destroy?
    @current_user.admin? || @current_user.id == @wiki.user_id
  end

  class Scope < Scope
    include CollaboratorsHelper
    def resolve
      if current_user == nil
        wikis = scope.all.where(private: false)
      else
        wikis = []
        if current_user.role == 'admin'
          wikis = scope.all # if the user is an admin, show them all the wikis
        elsif current_user.role == 'premium'
          all_wikis = scope.all
          all_wikis.each do |wiki|
            if !wiki.private? || wiki.user == current_user || wiki.collaborators.include?(current_user)
              wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
            end
          end
        else # this is the lowly standard user
          all_wikis = scope.all
          wikis = []
          all_wikis.each do |wiki|

            if !wiki.private? || is_a_current_collaborator?(wiki)
              wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
            end
          end
        end
        wikis # return the wikis array we've built up
      end
    end #resolve

      
  end


end