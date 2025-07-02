class BatteryPolicy < ApplicationPolicy
  def index?
    admin_only
  end

  def new?
    admin_only
  end

  def create?
    admin_only
  end

  def edit?
    admin_only
  end

  def update?
    admin_only
  end

  # Permite reaproveitar a lógica
  private

  def admin_only
    user.admin?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.admin? ? scope.all : scope.none
    end
  end
end
