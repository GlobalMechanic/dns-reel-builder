class AddIndexesEverywhere < ActiveRecord::Migration
  def change
    add_index :reels, :slug
    add_index :reel_clips, :reel_id
    add_index :reel_clips, :clip_id
  end
end
