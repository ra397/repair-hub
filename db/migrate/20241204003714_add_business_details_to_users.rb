class AddBusinessDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :business_name, :string
    add_column :users, :business_address, :string
    add_column :users, :business_phone, :string
  end
end
