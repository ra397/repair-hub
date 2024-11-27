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

# Generate 25 customers
25.times do |i|
  Customer.create!(
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}", # Generate a real-looking name
    address: "#{rand(100..999)} #{Faker::Address.street_name}, #{Faker::Address.city}",
    phone_number: "#{rand(1000000000..9999999999)}",
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
