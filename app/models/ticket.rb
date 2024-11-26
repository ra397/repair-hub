class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :customer
  has_many :line_items, dependent: :destroy

  validates :ticket_number, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: [ "New", "Awaiting Parts", "In Progress", "Awaiting Dropoff", "Billed", "Paid" ] }
  validates :device_name, length: { maximum: 50 }, allow_blank: true
  validates :device_model, length: { maximum: 50 }, allow_blank: true
  validates :device_serial, length: { maximum: 50 }, allow_blank: true
  before_validation :generate_ticket_number, on: :create

  private

  def generate_ticket_number
    return if ticket_number.present? # Avoid overwriting if already set
    year = Time.current.strftime("%y")
    last_ticket = Ticket.where("ticket_number LIKE ?", "#{year}-%").order(:created_at).last
    next_id = last_ticket&.ticket_number&.split("-")&.last.to_i + 1 || 1
    self.ticket_number = "#{year}-#{format('%04d', next_id)}"
  end
end
