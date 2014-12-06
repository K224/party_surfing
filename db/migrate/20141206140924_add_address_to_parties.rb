class AddAddressToParties < ActiveRecord::Migration
  def change
    add_column :parties, :address, :string
    add_column :parties, :address_hidden, :boolean
  end
end
