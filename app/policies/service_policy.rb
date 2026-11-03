class ServicePolicy < ApplicationPolicy
  # The list and the page of the services are public, as they were.
  def index?
    true
  end

  def show?
    true
  end

  def create?
    owner?
  end

  def update?
    owner?
  end

  def destroy?
    owner?
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end