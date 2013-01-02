class AddReelDescription < ActiveRecord::Migration
  def change
    add_column :reels, :description, :text
  end
end
