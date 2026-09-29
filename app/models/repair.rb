class Repair < ApplicationRecord
  belongs_to :bike
  belongs_to :mechanic, optional: true

  has_many :repair_services, dependent: :destroy
  has_many :services, through: :repair_services
  accepts_nested_attributes_for :repair_services, 
                              reject_if: proc { |attributes| attributes['service_id'].blank? }, 
                              allow_destroy: true
  # Enum de estados
  enum :status, {
    received: "received",
    quoted: "quoted",
    approved: "approved",
    in_progress: "in_progress",
    ready: "ready",
    delivered: "delivered",
    rejected: "rejected"
  }, validate: true

  # Scopes
  scope :open_repairs, -> { where(handed_back_at: nil) }
  scope :overdue, -> { open_repairs.where("promised_on < ?", Date.today) }
  scope :by_promised_date, -> { order(promised_on: :asc) }
  scope :newest_first, -> { order(created_at: :desc) }

  # Validaciones
  validates :status, presence: true
  validates :promised_on, presence: true
  validate :dates_chronology
  validate :handback_time_and_agreement_consistency

  def overdue?
    open_repairs? && promised_on.present? && promised_on < Date.today
  end

  def open_repairs?
    handed_back_at.nil?
  end

  def total
    repair_services.sum(:price_charged)
  end

  private

  def dates_chronology
    start_date = respond_to?(:entry_date) && entry_date.present? ? entry_date : created_at&.to_date
    return unless start_date.present?

    if promised_on.present? && promised_on < start_date
      errors.add(:promised_on, "cannot be before the entry date")
    end

    if handed_back_at.present? && handed_back_at.to_date < start_date
      errors.add(:handed_back_at, "cannot be before the entry date")
    end
  end

  def handback_time_and_agreement_consistency
    if status == "delivered" && handed_back_at.nil?
      errors.add(:handed_back_at, "must be recorded for delivered repairs")
    end

    if open_repairs? && handed_back_at.present?
      errors.add(:handed_back_at, "must be empty for repairs that are not handed back")
    end

    post_agreement_states = %w[approved in_progress ready delivered]
    if post_agreement_states.include?(status) && customer_agreed.nil?
      errors.add(:customer_agreed, "must be recorded for repairs in this state")
    end
  end
end