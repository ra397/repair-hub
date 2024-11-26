class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items do |t|
      t.string :description
      t.decimal :amount
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
