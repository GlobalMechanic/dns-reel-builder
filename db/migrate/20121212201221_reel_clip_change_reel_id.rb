class ReelClipChangeReelId < ActiveRecord::Migration
  def change
    remove_column :reel_clips, :id
    add_column :reel_clips, :reel_slug, :string
  end
end
