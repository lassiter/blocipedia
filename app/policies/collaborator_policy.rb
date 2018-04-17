class CollaboratorPolicy < ApplicationPolicy
  include CollaboratorsHelper

  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @collaborator = model 
  end

  def create?
    @current_user.id == @collaborator.wiki.user.id || @current_user.admin?
  end

  def destroy?
    return true if @current_user.admin?
    return true if @current_user == @collaborator.wiki.user
    return true if @current_user == @collaborator.user
    false
  end

 
end