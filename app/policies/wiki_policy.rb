class WikiPolicy < ApplicationPolicy

  def index?

  end

  def destroy?
    user.admin? || user.id == record.user_id
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.role == 'admin'
        scope.all
      elsif user.role == 'premium'
        user_wikis = scope.all
        all_wikis.each do |wiki|
          
        end
      else
        scope.where(public: true)
      end
    end
  end
end