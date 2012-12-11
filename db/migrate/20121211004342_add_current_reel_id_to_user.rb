class AddCurrentReelIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_reel_id, :integer
  end
end
