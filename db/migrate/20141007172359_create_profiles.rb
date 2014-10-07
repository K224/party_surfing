class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.string :photo
      t.integer :age
      t.text :contacts
      t.references :user, index: true

      t.timestamps
    end
  end
end
