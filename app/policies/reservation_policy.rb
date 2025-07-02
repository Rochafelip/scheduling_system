class ReservationPolicy < ApplicationPolicy
  def index?
    admin_only
  end

  def show?
    user&.admin? || record.user_id == user&.id
  end

  def create?
    true  # visitantes também podem criar
  end

  def update?
    admin_only
  end

  def destroy?
    admin_only
  end

  private

  def admin_only
    user&.admin?
  end

  class Scope
    attr_reader :user, :scope  # adiciona esses leitores

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user&.admin?
        scope.all
      elsif user
        scope.where(user_id: user.id)
      else
        scope.none
      end
    end
  end
end
