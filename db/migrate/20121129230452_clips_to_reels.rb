class ClipsToReels < ActiveRecord::Migration
  def self.up
    create_table :reels_clips, :id => false do |t|
      t.integer :reel_id
      t.integer :clip_id
    end
  end

  def self.down
    drop_table :reels_clips
  end
end
