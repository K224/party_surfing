class AddSocialAvatarToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :thumb_social_avatar, :string, default: nil
    add_column :profiles, :medium_social_avatar, :string, default: nil
  end
end
