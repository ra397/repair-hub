class Customer < ApplicationRecord
    validates :name, presence: true, length: { maximum: 100 }
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: 'must be 10 digits' }
    validates :address, length: { maximum: 255 }, allow_blank: true
end
