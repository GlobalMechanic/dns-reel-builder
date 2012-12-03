class ReelClipWeightToOrder < ActiveRecord::Migration
  def change
    rename_column :reel_clips, :weight, :order 
  end
end
