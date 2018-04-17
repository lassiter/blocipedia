class WikiPolicy < ApplicationPolicy
  attr_reader :current_user, :model
  include CollaboratorsHelper
  def initialize(current_user, model)
    @current_user = current_user
    @wiki = model
  end

  def index?
    @current_user
  end
  def create?
    @current_user
  end

  def update?
    return true if current_user.admin?
    if @wiki.private?
      @current_user.id == @wiki.user_id || are_a_current_collaborator?(@wiki.collaborators)
    else
      @current_user
    end
  end

  def destroy?
    @current_user.admin? || @current_user.id == @wiki.user_id
  end
  def able_to_add_and_see_collaborator?
    return true if @current_user.admin?
    return true if @current_user.id == @wiki.user_id && @current_user.role == 'premium'
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
            if !wiki.private? || wiki.user == current_user || wiki.users.include?(current_user)
              wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
            end
          end
        else # this is the lowly standard user
          all_wikis = scope.all
          wikis = []
          all_wikis.each do |wiki|
            if !wiki.private? || are_a_current_collaborator?(wiki.collaborators) # loops through active record array of collaborators
              wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
            end
          end
        end
        wikis # return the wikis array we've built up
      end
    end #resolve

      
  end


end