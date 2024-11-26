class AddUserToTickets < ActiveRecord::Migration[8.0]
  def change
    add_reference :tickets, :user, null: false, foreign_key: true
  end
end
