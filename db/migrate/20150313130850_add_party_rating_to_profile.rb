class AddPartyRatingToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :host_rating_sum, :integer, default: 0
    add_column :profiles, :host_rating_num, :integer, default: 0
  end
end
