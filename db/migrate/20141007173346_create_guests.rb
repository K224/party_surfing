class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.references :party, index: true
      t.references :user, index: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
