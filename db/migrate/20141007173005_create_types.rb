class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :title
      t.text :description
    end
  end
end
