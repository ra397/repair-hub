class User < ApplicationRecord
    has_secure_password

    has_many :tickets, dependent: :destroy
    has_many :customers, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    validates :business_name, presence: true, length: { maximum: 255 }, if: :require_business_info
    validates :business_address, presence: true, length: { maximum: 500 }, if: :require_business_info
    validates :business_phone, presence: true, format: { with: Regex::PHONE, message: "must be a valid phone number" }, if: :require_business_info

    attr_accessor :require_business_info

    def require_business_info?
      ActiveModel::Type::Boolean.new.cast(require_business_info)
    end

    def business_info_complete?
      business_name.present? && business_address.present? && business_phone.present?
    end
end
