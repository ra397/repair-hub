class Customer < ApplicationRecord
  belongs_to :user
  has_many :tickets, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
  validates :email, allow_blank: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }
  validates :phone_number, allow_blank: true, format: { with: Regex::PHONE, message: "is invalid" }
  validates :address, length: { maximum: 255 }, allow_blank: true

  # Custom validation to ensure at least one contact method
  validate :phone_or_email_present

  private

  def phone_or_email_present
    if phone_number.blank? && email.blank?
      errors.add(:base, "Either phone number or email must be provided.")
    end
  end
end
