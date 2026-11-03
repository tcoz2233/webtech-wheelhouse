class RepairPolicy < ApplicationPolicy
  def index?
    signed_in?
  end

  def show?
    owner? || counter? || own_repair?
  end

  def create?
    owner? || counter?
  end

  def update?
    owner? || ((counter? || own_repair?) && !record.handed_back?)
  end

  def destroy?
    owner?
  end

  def permitted_attributes
    if owner? || counter?
      [
        :bike_id, :mechanic_id, :promised_on, :status, :customer_agreed, :diagnosis,
        { photos: [], repair_services_attributes: [ :id, :service_id, :price_charged, :_destroy ] }
      ]
    elsif mechanic?
      [ :status, :diagnosis, { photos: [] } ]
    else
      []
    end
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      if owner? || counter?
        scope.all
      elsif mechanic? && user.mechanic_id.present?
        scope.where(mechanic_id: user.mechanic_id)
      else
        scope.none
      end
    end
  end

  private

  def own_repair?
    mechanic? && user.mechanic_id.present? && record.mechanic_id == user.mechanic_id
  end
end