class CollaboratorPolicy < ApplicationPolicy
include CollaboratorsHelper

  attr_reader :current_user, :model
  def initialize(current_user, model)
    @current_user = current_user
    @collaborator = model 

  end

  def create?
    @current_user.id == @collaborator.wiki[0].user.id || @current_user.admin?
  end

  def destroy?
    is_the_wiki_owner?(@collaborators) || is_a_collaborator?(@collaborator) || @current_user.admin?
  end

 
end