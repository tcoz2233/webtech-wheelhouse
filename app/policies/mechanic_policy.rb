# Policy of the staff (the Mechanic model).
class MechanicPolicy < ApplicationPolicy
  def index?
    signed_in?
  end

  def show?
    signed_in?
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
      signed_in? ? scope.all : scope.none
    end
  end
end