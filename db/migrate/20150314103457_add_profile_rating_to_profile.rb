class AddProfileRatingToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_rating_sum, :integer, default: 0
    add_column :profiles, :profile_rating_num, :integer, default: 0
 end
end
