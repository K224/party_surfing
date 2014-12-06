class AddFieldsWithContactsAndBoolsToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :birthday_hidden, :boolean
    add_column :profiles, :skype, :string
    add_column :profiles, :skype_hidden, :boolean
    add_column :profiles, :phone, :string
    add_column :profiles, :phone_hidden, :boolean
    add_column :profiles, :vk, :string
    add_column :profiles, :vk_hidden, :boolean
    add_column :profiles, :fb, :string
    add_column :profiles, :fb_hidden, :boolean
  end
end
