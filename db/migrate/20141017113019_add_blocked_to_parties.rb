class AddBlockedToParties < ActiveRecord::Migration
  def change
    add_column :parties, :blocked, :boolean, default:false
    add_column :parties, :block_message, :text
  end
end
