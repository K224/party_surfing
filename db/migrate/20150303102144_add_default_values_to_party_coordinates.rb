class AddDefaultValuesToPartyCoordinates < ActiveRecord::Migration
  def change
    change_column :parties, :coord_latitude, :float, default: 1000
    change_column :parties, :coord_longitude, :float, default: 1000
  end
end
