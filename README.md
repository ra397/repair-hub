# Repair Hub

**Repair Hub** is a simple Rails application designed for a single-user environment to manage tickets for device repairs. It features ticket tracking, customer management, and an intuitive workflow for efficiently handling repair jobs.

## **Highlights**

### **Tickets**

- Automatically generated ticket numbers (e.g., `24-0001` for the first ticket in 2024).
- Track device details including:
  - Device name
  - Model
  - Serial number
  - Status
- Associate tickets with customers.
- Full CRUD functionality for tickets.

### **Customers**

- Store customer details like:
  - Name
  - Address
  - Phone number
  - Email
- Link customers to their tickets.
- Full CRUD functionality for customers.

### **Authentication**

- Simple, secure login system for single-user access.
- No signup required; pre-configured credentials stored securely in Rails encrypted credentials.

