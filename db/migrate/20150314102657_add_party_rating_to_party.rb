class AddPartyRatingToParty < ActiveRecord::Migration
  def change
    add_column :parties, :party_rating_sum, :integer, default: 0
    add_column :parties, :party_rating_num, :integer, default: 0
  end
end
