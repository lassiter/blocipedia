class ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @model = model
  end

  def index?
    false
  end

  def show?
    scope.where(:id => model.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    current_user.present?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(current_user, model.class)
  end

  class Scope
    attr_reader :current_user, :scope

    def initialize(current_user, scope)
      @current_user = current_user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end