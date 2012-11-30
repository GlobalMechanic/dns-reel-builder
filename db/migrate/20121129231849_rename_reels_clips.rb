class RenameReelsClips < ActiveRecord::Migration
  def change
    rename_table :reels_clips, :clips_reels
  end
end
