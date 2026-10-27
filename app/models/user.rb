class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :repairs, dependent: :nullify
  belongs_to :mechanic, optional: true

  enum :role, { counter: "counter", mechanic: "mechanic", owner: "owner" }, default: "counter", validate: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :email_address, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 10, message: "must be at least 10 characters long" }, allow_nil: true

  before_destroy :prevent_staff_destruction

  private

    def prevent_staff_destruction
      if mechanic.present?
        errors.add(:base, "A member of the staff who has an account cannot be destroyed.")
        throw(:abort)
      end
    end
end