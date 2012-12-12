class ReelClipsRenameReelSlug < ActiveRecord::Migration
  def change
    rename_column :reel_clips, :reel_slug, :reel_id
  end
end
