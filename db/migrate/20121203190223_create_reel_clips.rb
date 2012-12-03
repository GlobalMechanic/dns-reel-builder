class CreateReelClips < ActiveRecord::Migration
  def change
    create_table :reel_clips do |t|
      t.integer :reel_id
      t.integer :clip_id
      t.integer :weight

      t.timestamps
    end
  end
end
