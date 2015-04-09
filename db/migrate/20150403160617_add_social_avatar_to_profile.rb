class AddSocialAvatarToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :social_avatar, :string, default: nil
  end
end
