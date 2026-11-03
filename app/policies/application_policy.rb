
class ApplicationPolicy
  include PolicyRoles

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def permitted_attributes
    []
  end

  # Used by the views: may this person write this field?
  def permitted_attribute?(name)
    permitted_attributes.any? do |attribute|
      attribute.is_a?(Hash) ? attribute.key?(name) : attribute == name
    end
  end

  class Scope
    include PolicyRoles

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.none
    end

    private

    attr_reader :user, :scope
  end
end