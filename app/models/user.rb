class User < ApplicationRecord
    has_secure_password

    has_many :tickets, dependent: :destroy
    has_many :customers, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

    validates :business_name, allow_blank: true, length: { maximum: 255 }
    validates :business_address, allow_blank: true, length: { maximum: 500 }
    validates :business_phone, allow_blank: true, format: { with: Regex::PHONE, message: "must be a valid phone number" }
end
