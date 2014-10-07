class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :title
      t.text :summary
      t.float :coord_longitude
      t.float :coord_latitude
      t.references :host, index: true
      t.references :type, index: true

      t.timestamps
    end
  end
end
