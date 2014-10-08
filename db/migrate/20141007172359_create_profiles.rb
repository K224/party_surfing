class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name, default: 'Anonymous'
      t.string :surname, default: 'Anonymous'
      t.string :photo
      t.date :birthday, default: Date.today
      t.text :contacts
      t.references :user, index: true

      t.timestamps
    end
  end
end
