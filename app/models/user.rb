class User < ApplicationRecord
    has_secure_password

    has_many :tickets, dependent: :destroy
    has_many :customers, dependent: :destroy

    validates :username, presence: true, uniqueness: true
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
