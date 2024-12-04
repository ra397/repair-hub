# db/seeds.rb
# run this using bin/rails db:seed

require 'faker'

# Clear existing data to avoid duplicates
LineItem.delete_all
Ticket.delete_all
Customer.delete_all
User.delete_all

# Create users
user1 = User.create!(username: "techguy", password: "password123")
user2 = User.create!(username: "repairqueen", password: "securepass")

# Helper method to generate phone numbers in the format 123-123-1234
def generate_phone_number
  "#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}"
end

# Helper method to generate a random two-line address
def generate_address
  street_number = rand(1..9999)
  street_name = Faker::Address.street_name
  street_suffix = ["Drive", "Street", "Court", "Avenue", "Lane"].sample
  city = Faker::Address.city
  state = Faker::Address.state
  zipcode = Faker::Address.zip_code

  "#{street_number} #{street_name} #{street_suffix}\n#{city}, #{state} #{zipcode}"
end

# Generate 25 customers
25.times do |i|
  Customer.create!(
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}", # Generate a real-looking name
    address: generate_address,
    phone_number: generate_phone_number,
    email: Faker::Internet.email,
    user_id: [user1.id, user2.id].sample
  )
end

# Generate tickets and line items
customers = Customer.all
current_year = Time.now.year % 100 # e.g., 2025 -> 25
ticket_counter = 1

customers.each do |customer|
  rand(1..3).times do # Each customer can have 1 to 3 tickets
    ticket = Ticket.create!(
      ticket_number: format("%<year>02d-%<id>04d", year: current_year, id: ticket_counter),
      device_name: ["Laptop", "Smartphone", "Tablet", "Desktop"].sample,
      device_model: ["Model A", "Model B", "Model C", "Model D"].sample,
      device_serial: "SN#{rand(100000..999999)}",
      status: ["New", "Awaiting Parts", "In Progress", "Awaiting Dropoff", "Billed", "Paid"].sample,
      customer_id: customer.id,
      user_id: customer.user_id
    )
    ticket_counter += 1

    # Add random line items to the ticket
    rand(1..5).times do
      LineItem.create!(
        description: ["Screen Replacement", "Battery Replacement", "Software Installation", "Keyboard Repair", "Data Recovery"].sample,
        amount: rand(50.0..300.0).round(2),
        ticket_id: ticket.id
      )
    end
  end
end

puts "Database seeded successfully with #{User.count} users, #{Customer.count} customers, #{Ticket.count} tickets, and #{LineItem.count} line items!"
