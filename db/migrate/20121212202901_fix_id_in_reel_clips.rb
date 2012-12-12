class FixIdInReelClips < ActiveRecord::Migration
  def change
    rename_column :reel_clips, :reel_id, :id
  end
end
