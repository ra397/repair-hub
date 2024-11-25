class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.string :ticket_number
      t.string :device_name
      t.string :device_model
      t.string :device_serial
      t.string :status
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
