class WikiPolicy < ApplicationPolicy

  def initialize(current_user, model) #mentor
    @current_user = current_user
    @wiki = model #mentor
  end

  def index?
    
  end
  def create?
    @current_user
  end

  def update?
    @current_user
  end

  def destroy?
    @current_user.admin? || @current_user.id == @wiki.user_id
  end

 
end